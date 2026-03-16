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
    # Focus windows (dwl: Super+j/k) — wrap around in workspace
    ctrl-j = 'focus --boundaries workspace down'
    ctrl-k = 'focus --boundaries workspace up'
    ctrl-h = 'focus --boundaries workspace left'
    ctrl-l = 'focus --boundaries workspace right'

    # Move windows
    ctrl-shift-j = 'move down'
    ctrl-shift-k = 'move up'
    ctrl-shift-h = 'move left'
    ctrl-shift-l = 'move right'

    # Resize (dwl: Super+Left/Right)
    ctrl-left = 'resize width -50'
    ctrl-right = 'resize width +50'
    ctrl-up = 'resize height +50'
    ctrl-down = 'resize height -50'

    # Layouts (dwl: Super+w tile, Super+v monocle)
    ctrl-w = 'layout tiles horizontal vertical'
    ctrl-v = 'layout accordion horizontal vertical'

    # Toggle float (dwl: Super+f)
    ctrl-f = 'layout floating tiling'

    # Fullscreen (dwl: Super+e)
    ctrl-e = 'fullscreen'

    # Close window (dwl: Super+q)
    ctrl-q = 'close'

    # Workspaces (dwl: Super+1-9)
    ctrl-1 = 'workspace 1'
    ctrl-2 = 'workspace 2'
    ctrl-3 = 'workspace 3'
    ctrl-4 = 'workspace 4'
    ctrl-5 = 'workspace 5'
    ctrl-6 = 'workspace 6'
    ctrl-7 = 'workspace 7'
    ctrl-8 = 'workspace 8'
    ctrl-9 = 'workspace 9'

    # Move to workspace (dwl: Super+Shift+1-9)
    ctrl-shift-1 = 'move-node-to-workspace 1'
    ctrl-shift-2 = 'move-node-to-workspace 2'
    ctrl-shift-3 = 'move-node-to-workspace 3'
    ctrl-shift-4 = 'move-node-to-workspace 4'
    ctrl-shift-5 = 'move-node-to-workspace 5']
    ctrl-shift-6 = 'move-node-to-workspace 6']
    ctrl-shift-7 = 'move-node-to-workspace 7'
    ctrl-shift-8 = 'move-node-to-workspace 8'
    ctrl-shift-9 = 'move-node-to-workspace 9'

    # Previous workspace (dwl: Super+Tab)
    ctrl-tab = 'workspace-back-and-forth'

    # Launch apps (dwl: Super+t terminal, Super+b browser)
    ctrl-t = 'exec-and-forget open -a Ghostty'
    ctrl-b = 'exec-and-forget open -a Zen'

    # Resize mode (dwl: Super+Left/Right for finer control)
    ctrl-r = 'mode resize'

    # Window rules — assign apps to workspaces (mirrors river rules)
    # Workspace 4: Terminal
    [[on-window-detected]]
    if.app-id = 'com.mitchellh.ghostty'
    run = ['move-node-to-workspace 4']

    # Workspace 5: Browser (firefox on river)
    [[on-window-detected]]
    if.app-id = 'org.mozilla.firefox'
    run = ['move-node-to-workspace 5']

    # Workspace 6: Chat (QQ, Discord on river)
    [[on-window-detected]]
    if.app-id = 'com.tencent.qq'
    run = ['move-node-to-workspace 6']

    [[on-window-detected]]
    if.app-id = 'com.hnc.Discord'
    run = ['move-node-to-workspace 6']

    [[on-window-detected]]
    if.app-id = 'com.tencent.xinWeChat'
    run = ['move-node-to-workspace 6']

    # Workspace 7: Email
    [[on-window-detected]]
    if.app-id = 'org.mozilla.thunderbird'
    run = ['move-node-to-workspace 7']

    [mode.resize.binding]
    h = 'resize width -50'
    l = 'resize width +50'
    j = 'resize height -50'
    k = 'resize height +50'
    enter = 'mode main'
    esc = 'mode main'
  '';
}
