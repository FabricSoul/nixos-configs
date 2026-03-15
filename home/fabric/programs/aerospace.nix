# home/fabric/programs/aerospace.nix — Aerospace tiling WM config (darwin-only)
{...}: {
  home.file.".aerospace.toml".text = ''
    # AeroSpace tiling window manager config
    # Keybindings mirror dwl setup

    config-version = 2
    start-at-login = true
    enable-normalization-flatten-containers = true
    enable-normalization-opposite-orientation-for-nested-containers = true
    default-root-container-layout = 'tiles'
    default-root-container-orientation = 'auto'
    on-focus-changed = ['move-mouse window-lazy-center']

    [key-mapping]
    preset = 'qwerty'

    [gaps]
    inner.horizontal = 4
    inner.vertical = 4
    outer.left = 4
    outer.bottom = 4
    outer.top = 4
    outer.right = 4

    [mode.main.binding]
    # Focus windows (dwl: Super+j/k)
    cmd-j = 'focus down'
    cmd-k = 'focus up'
    cmd-h = 'focus left'
    cmd-l = 'focus right'

    # Move windows
    cmd-shift-j = 'move down'
    cmd-shift-k = 'move up'
    cmd-shift-h = 'move left'
    cmd-shift-l = 'move right'

    # Resize (dwl: Super+Left/Right)
    cmd-left = 'resize width -50'
    cmd-right = 'resize width +50'
    cmd-up = 'resize height +50'
    cmd-down = 'resize height -50'

    # Layouts (dwl: Super+w tile, Super+v monocle)
    cmd-w = 'layout tiles horizontal vertical'
    cmd-v = 'layout accordion horizontal vertical'

    # Toggle float (dwl: Super+f)
    cmd-f = 'layout floating tiling'

    # Fullscreen (dwl: Super+e)
    cmd-e = 'fullscreen'

    # Close window (dwl: Super+q)
    cmd-q = 'close'

    # Workspaces (dwl: Super+1-9)
    cmd-1 = 'workspace 1'
    cmd-2 = 'workspace 2'
    cmd-3 = 'workspace 3'
    cmd-4 = 'workspace 4'
    cmd-5 = 'workspace 5'
    cmd-6 = 'workspace 6'
    cmd-7 = 'workspace 7'
    cmd-8 = 'workspace 8'
    cmd-9 = 'workspace 9'

    # Move to workspace (dwl: Super+Shift+1-9)
    cmd-shift-1 = 'move-node-to-workspace 1'
    cmd-shift-2 = 'move-node-to-workspace 2'
    cmd-shift-3 = 'move-node-to-workspace 3'
    cmd-shift-4 = 'move-node-to-workspace 4'
    cmd-shift-5 = 'move-node-to-workspace 5'
    cmd-shift-6 = 'move-node-to-workspace 6'
    cmd-shift-7 = 'move-node-to-workspace 7'
    cmd-shift-8 = 'move-node-to-workspace 8'
    cmd-shift-9 = 'move-node-to-workspace 9'

    # Previous workspace (dwl: Super+Tab)
    cmd-tab = 'workspace-back-and-forth'

    # Launch apps (dwl: Super+t terminal, Super+b browser)
    cmd-t = 'exec-and-forget open -a Ghostty'
    cmd-b = 'exec-and-forget open -a Zen'

    # Resize mode (dwl: Super+Left/Right for finer control)
    cmd-r = 'mode resize'

    [mode.resize.binding]
    h = 'resize width -50'
    l = 'resize width +50'
    j = 'resize height -50'
    k = 'resize height +50'
    enter = 'mode main'
    esc = 'mode main'
  '';
}
