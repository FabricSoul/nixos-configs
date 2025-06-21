{...}: {
  xdg.desktopEntries = {
    # The name of the entry. This becomes the filename, e.g., "firefox-private.desktop"
    discord = {
      # The name that will appear in Wofi
      name = "Discord";

      # A more generic name, also used by menus
      genericName = "Discord";

      # This is the most important part!
      # The command to execute. %U is a placeholder for URLs if you open a link with it.
      exec = "discord --enable-wayland-ime";

      # Tell the system this is not a terminal application
      terminal = false;

      # Use the standard Firefox icon for a consistent look
      icon = "discord";

      # The type of the entry
      type = "Application";
    };
  };
}
