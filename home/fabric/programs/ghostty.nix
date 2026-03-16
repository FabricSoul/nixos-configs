# home/fabric/programs/ghostty.nix — Ghostty terminal config (darwin)
# After OS-level Ctrl↔Cmd swap, physical Ctrl sends Cmd to the OS.
# Remap all cmd+letter → ctrl characters so terminal Ctrl shortcuts work.
{...}: {
  home.file.".config/ghostty/config".text = ''
    # Hide titlebar (disables drag area, use aerospace to move windows)
    macos-titlebar-style = hidden

    # Font
    font-family = FiraMono Nerd Font Mono
    font-size = 14

    # Catppuccin Mocha (matches foot/NixOS setup)
    background = 1E1E2E
    foreground = CDD6F4
    background-opacity = 0.80

    palette = 0=#45475A
    palette = 1=#F38BA8
    palette = 2=#A6E3A1
    palette = 3=#F9E2AF
    palette = 4=#89B4FA
    palette = 5=#F5C2E7
    palette = 6=#94E2D5
    palette = 7=#BAC2DE
    palette = 8=#585B70
    palette = 9=#F38BA8
    palette = 10=#A6E3A1
    palette = 11=#F9E2AF
    palette = 12=#89B4FA
    palette = 13=#F5C2E7
    palette = 14=#94E2D5
    palette = 15=#A6ADC8

    # Disable Ghostty tabs — use tmux instead
    keybind = cmd+t=unbind
    keybind = cmd+shift+t=unbind
    keybind = cmd+w=unbind

    # After Ctrl↔Cmd swap: physical Ctrl+key → OS Cmd+key
    # Remap to send actual Ctrl characters to the terminal
    keybind = cmd+a=text:\x01
    keybind = cmd+b=text:\x02
    keybind = cmd+c=text:\x03
    keybind = cmd+d=text:\x04
    keybind = cmd+e=text:\x05
    keybind = cmd+f=text:\x06
    keybind = cmd+g=text:\x07
    keybind = cmd+h=text:\x08
    keybind = cmd+k=text:\x0b
    keybind = cmd+l=text:\x0c
    keybind = cmd+n=text:\x0e
    keybind = cmd+o=text:\x0f
    keybind = cmd+p=text:\x10
    keybind = cmd+q=text:\x11
    keybind = cmd+r=text:\x12
    keybind = cmd+s=text:\x13
    keybind = cmd+u=text:\x15
    keybind = cmd+v=text:\x16
    keybind = cmd+w=text:\x17
    keybind = cmd+x=text:\x18
    keybind = cmd+y=text:\x19
    keybind = cmd+z=text:\x1a

    # Copy/paste: Ctrl+Shift+C/V (Linux terminal style)
    keybind = cmd+shift+c=copy_to_clipboard
    keybind = cmd+shift+v=paste_from_clipboard
  '';
}
