{
  pkgs,
  eden,
  ...
}: {
  home.packages = [
    eden.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
