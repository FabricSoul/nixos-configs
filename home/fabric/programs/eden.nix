{
  pkgs,
  eden,
  ...
}: {
  home.packages = [
    eden.packages.${pkgs.system}.default
  ];
}
