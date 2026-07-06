# X3 存档滚动备份:NixOS-generation 式,git 内容寻址,append-only。
# 机制:systemd path unit(inotify)监视存档目录 → 存盘触发 x3gen snapshot
#       → gzip -t 拦坏档 → 有实际变化才 commit,并打 tag gen-N。
# 日常:x3gen list / x3gen restore gen-N / 手动 x3gen snapshot。
{pkgs, ...}: let
  x3gen = pkgs.writeShellApplication {
    name = "x3gen";
    runtimeInputs = with pkgs; [git gzip gnutar coreutils findutils inotify-tools];
    text = builtins.readFile ./x3gen.sh;
  };
in {
  home.packages = [x3gen];

  systemd.user.services.x3gen = {
    Unit.Description = "Snapshot X3 save games into the generation store";
    Service = {
      Type = "oneshot";
      # 存盘后稍等落盘再抓;坏/半写的档由脚本内 gzip -t 闸拦下
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 4";
      ExecStart = "${x3gen}/bin/x3gen snapshot";
    };
  };

  systemd.user.paths.x3gen = {
    Unit.Description = "Watch X3 save dirs and snapshot on change";
    Path.PathModified = [
      "%h/.config/EgoSoft/X3TC/save"
      "%h/.config/EgoSoft/X3AP/save"
      # systemd Path 不支持 glob,UID 子目录写死(换 Steam 账号需更新)
      # X4 不备份(增长太快;要恢复时连同 x3gen.sh 里的注释一起解开):
      # "%h/.config/EgoSoft/X4/428787712/save"
      "%h/.config/EgoSoft/X Rebirth/428787712/save"
      # 装了 X3FL 后解开:
      # "%h/.config/EgoSoft/X3FL/save"
    ];
    Install.WantedBy = ["default.target"];
  };
}
