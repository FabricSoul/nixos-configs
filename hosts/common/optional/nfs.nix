# hosts/common/optional/nfs.nix
{...}: {
  # Enable NFS server
  services.nfs.server = {
    enable = true;

    # Define your exports
    exports = ''
      /nas 192.168.2.101(rw,sync,no_root_squash,no_subtree_check) 100.0.0.0/8(rw,sync,no_root_squash,no_subtree_check)
    '';

    # Enable NFSv4 (recommended)
    # Remove this line if you need to stick with NFSv2/v3 only
    createMountPoints = true;
  };

  # Ensure the directories exist
  systemd.tmpfiles.rules = [
    "d /nas 0755 root root -"
  ];
}
