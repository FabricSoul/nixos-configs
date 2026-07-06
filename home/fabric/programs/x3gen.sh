# x3gen — NixOS-generation-style rolling backup for Egosoft save games.
# (由 writeShellApplication 包装;wrapper 已注入 shebang 与 set -euo pipefail)
#
# 存储 = 一个 git 仓库。X3 系 / X Rebirth 存【解压后的 XML】(git 内容寻址 + 增量
#        压缩,相同内容只存一份,每代只占 delta)。X4 默认存【原始 .xml.gz】——
#        它解压后 ~650MB/档,超过 git 增量压缩阈值,解压毫无去重收益还占地,
#        raw 模式每个变动档每代约 +80M(gz 大小),诚实可预期。
#        历史 append-only,只有手动 prune 才会删。每代 = commit + tag(gen-N)。
#
# 防坏档 = 只有 `gzip -t` 校验通过的存档才入库;写一半/损坏的跳过,且保留镜像里
#          上一个好版本。内容无变化不产生新代。未变动的存档跳过处理(mtime 同步)。
#
# 用法:
#   x3gen snapshot            手动抓一代(无变化则不产生新代)
#   x3gen watch               前台监视(inotify;平时由 systemd path unit 代劳)
#   x3gen list                列出所有 generation
#   x3gen restore <代> [目录]  导出某一代(gen-3 / 3 / 提交哈希;默认 ~/x3-restore)
#   x3gen prune               如何手动删代的说明(唯一需要手动的操作)
#
# 环境变量:X3GEN_STORE 改仓库位置;X3GEN_RAW=1 全部存原字节;
#          X3GEN_RAW_GAMES 覆盖按游戏的 raw 名单(默认 "X4";空串=全部解压)。
#          注意:切换 raw/解压会改变镜像文件名,会产生一个大差异代。
set -euo pipefail

SAVE_DIRS=(
  "$HOME/.config/EgoSoft/X3TC/save"
  "$HOME/.config/EgoSoft/X3AP/save"
  "$HOME/.config/EgoSoft/X3FL/save" # 以后装了 FL 自动纳入
  # X4 不备份(存档 ~650M/档、自动存档轮换频繁,store 增长太快;要恢复时解开):
  # "$HOME/.config/EgoSoft/X4"/*/save
  "$HOME/.config/EgoSoft/X Rebirth"/*/save # UID 子目录由 glob 展开
)
STORE="${X3GEN_STORE:-$HOME/x3-save-generations}"
RAW="${X3GEN_RAW:-0}"
RAW_GAMES="${X3GEN_RAW_GAMES-X4}"

git_s() { git -C "$STORE" "$@"; }

is_raw() { # $1 = 游戏名
  [ "$RAW" = 1 ] && return 0
  case " $RAW_GAMES " in *" $1 "*) return 0 ;; esac
  return 1
}

init() {
  if [ ! -d "$STORE/.git" ]; then
    mkdir -p "$STORE"
    git_s init -q
    git_s commit -q --allow-empty -m "gen 0 · empty store · $(date -u +%FT%TZ)"
    git_s tag gen-0
  fi
}

# 把当前【校验通过的】存档镜像进仓库工作区(增量:mtime 相同则跳过)
capture() {
  local dir game f base outname out
  shopt -s nullglob
  for dir in "${SAVE_DIRS[@]}"; do
    [ -d "$dir" ] || continue
    game=$(basename "$(dirname "$dir")") # X3TC / X3AP / 428787712(UID)
    if [[ "$game" =~ ^[0-9]+$ ]]; then   # X4 / X Rebirth 多一层 UID
      game=$(basename "$(dirname "$(dirname "$dir")")")
    fi
    game="${game// /}" # "X Rebirth" -> "XRebirth"
    local -A wanted=()
    mkdir -p "$STORE/$game"
    for f in "$dir"/*.sav "$dir"/*.xml.gz; do
      base=$(basename "$f")
      if is_raw "$game"; then
        outname="$base"
      elif [[ "$base" == *.xml.gz ]]; then
        outname="${base%.gz}"
      else
        outname="$base.xml"
      fi
      # 先登记:即使新文件损坏,也保住镜像里上一个好版本不被清理
      wanted[$outname]=1
      out="$STORE/$game/$outname"
      # mtime 未变 → 未修改,跳过(镜像写入时用 touch -r 对齐源 mtime)
      if [ -e "$out" ] && [ ! "$f" -nt "$out" ] && [ ! "$out" -nt "$f" ]; then
        continue
      fi
      if ! gzip -t "$f" 2>/dev/null; then
        echo "  ! 跳过(坏/写一半): $game/$base" >&2
        continue
      fi
      if is_raw "$game"; then
        cp -p "$f" "$out"
      else
        gzip -dc "$f" >"$out" # 解压 → git 高效增量
        touch -r "$f" "$out"
      fi
    done
    # 源里已删除的存档,从镜像中移除(删除也是历史的一部分)
    for f in "$STORE/$game"/*; do
      [ -f "$f" ] || continue
      base=$(basename "$f")
      [ -n "${wanted[$base]:-}" ] || rm -f "$f"
    done
  done
  shopt -u nullglob
}

cmd_snapshot() {
  init
  capture
  git_s add -A
  if git_s diff --cached --quiet; then
    echo "无变化 — 不产生新 generation"
  else
    local n
    n=$(git_s rev-list --count HEAD)
    git_s commit -q -m "gen $n · $(date -u +%FT%TZ)"
    git_s tag "gen-$n"
    echo "✔ 已提交 generation gen-$n  ($(git_s rev-parse --short HEAD))"
  fi
}

cmd_watch() {
  init
  echo "监视中: ${SAVE_DIRS[*]}"
  if command -v inotifywait >/dev/null 2>&1; then
    local dirs=() d
    for d in "${SAVE_DIRS[@]}"; do [ -d "$d" ] && dirs+=("$d"); done
    while inotifywait -q -e close_write --include '.*\.(sav|xml\.gz)$' "${dirs[@]}" >/dev/null; do
      sleep 3
      cmd_snapshot
    done
  else
    echo "(未装 inotifywait — 每 60s 轮询)"
    while true; do
      cmd_snapshot
      sleep 60
    done
  fi
}

cmd_list() {
  init
  git_s log --pretty='%C(yellow)%h%Creset %C(green)%d%Creset %ad  %s' --date=format:'%Y-%m-%d %H:%M'
}

# 把 "gen-3" / "gen3" / "3" 解析成提交;其它输入当哈希/引用原样返回
resolve() {
  local q="$1" n
  n="${q#gen}"
  n="${n#-}"
  if git_s rev-parse -q --verify "refs/tags/gen-$n" >/dev/null 2>&1; then
    git_s rev-parse "refs/tags/gen-$n"
  elif [[ "$n" =~ ^[0-9]+$ ]]; then
    git_s log --grep="gen $n " --format=%H -1 # 兼容早期未打 tag 的代
  else
    echo "$q"
  fi
}

cmd_restore() {
  init
  local ref out
  ref=$(resolve "${1:?用法: x3gen restore <代> [目录]}")
  out="${2:-$HOME/x3-restore}"
  mkdir -p "$out"
  git_s archive "$ref" | tar -x -C "$out"
  echo "已导出 $1 → $out"
  echo "解压格式(X3系/XRebirth)放回游戏时重新 gzip,例如:"
  echo "  gzip -c '$out/X3TC/X13.sav.xml' > ~/.config/EgoSoft/X3TC/save/X13.sav"
  echo "raw 格式(X4)直接拷回,例如:"
  echo "  cp '$out/X4/save_001.xml.gz' ~/.config/EgoSoft/X4/<UID>/save/"
}

cmd_prune() {
  echo "prune 会重写历史(彻底删除某代的数据)。请显式操作:"
  echo "  cd $STORE && git log --oneline   # 找到要删的代"
  echo "  git tag -d gen-N                 # 只删标签(数据仍在链上)"
  echo "  # 要真正回收空间需重写历史:git rebase -i / git-filter-repo,然后:"
  echo "  git reflog expire --expire=now --all && git gc --prune=now"
}

case "${1:-}" in
snapshot | snap) cmd_snapshot ;;
watch) cmd_watch ;;
list | log) cmd_list ;;
restore)
  shift
  cmd_restore "$@"
  ;;
prune) cmd_prune ;;
*)
  echo "usage: x3gen {snapshot|watch|list|restore <代> [目录]|prune}"
  exit 1
  ;;
esac
