# home/fabric/darwin.nix — macOS-specific home config
{pkgs, ...}: {
  imports = [
    ./programs/aerospace.nix
  ];

  home.homeDirectory = "/Users/fabric";

  # darwin-specific packages (most GUI apps managed via homebrew casks)
  home.packages = with pkgs; [
  ];
}
