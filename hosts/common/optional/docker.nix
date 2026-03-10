# hosts/common/optional/docker.nix
{...}: {
  virtualisation.docker.enable = true;

  # Enable NVIDIA Container Toolkit for GPU passthrough
  hardware.nvidia-container-toolkit.enable = true;
}
