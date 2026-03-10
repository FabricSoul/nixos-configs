{pkgs, ...}: {
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;

    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      fcitx5-pinyin-zhwiki
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-minecraft
    ];
  };
}
