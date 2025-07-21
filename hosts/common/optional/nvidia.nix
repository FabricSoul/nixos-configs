# hosts/common/optional/nvidia.nix
{
  config,
  lib,
  pkgs,
  nvidiaPkgs,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "565.77";
      #
      #   sha256_64bit = "sha256-CnqnQsRrzzTXZpgkAtF7PbH9s7wbiTRNcM0SPByzFHw=";
      #   sha256_aarch64 = "sha256-LSAYUnhfnK3rcuPe1dixOwAujSof19kNOfdRHE7bToE=";
      #   openSha256 = "sha256-Fxo0t61KQDs71YA8u7arY+503wkAc1foaa51vi2Pl5I=";
      #   settingsSha256 = "sha256-VUetj3LlOSz/LB+DDfMCN34uA4bNTTpjDrb6C6Iwukk=";
      #   persistencedSha256 = "sha256-wnDjC099D8d9NJSp9D0CbsL+vfHXyJFYYgU3CwcqKww=";
      #
      #   # Optional: include patches from that version if needed
      #   # patches = [
      #   #   ./fix-for-linux-6.13.patch
      #   # ];
      #   # patchesOpen = [
      #   #   ./nvidia-nv-Convert-symbol-namespace-to-string-literal.patch
      #   #   ./crypto-Add-fix-for-6.13-Module-compilation.patch
      #   #   ./Use-linux-aperture.c-for-removing-conflict.patch
      #   #   ./TTM-fbdev-emulation-for-Linux-6.13.patch
      #   # ];
      # };

      # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "555.58";
      #
      #   sha256_64bit = "sha256-bXvcXkg2kQZuCNKRZM5QoTaTjF4l2TtrsKUvyicj5ew=";
      #   sha256_aarch64 = lib.fakeSha256;
      #   openSha256 = lib.fakeSha256;
      #   settingsSha256 = "sha256-vWnrXlBCb3K5uVkDFmJDVq51wrCoqgPF03lSjZOuU8M=";
      #   persistencedSha256 = lib.fakeSha256;
      # };
    };
  };
}
