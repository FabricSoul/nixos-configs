{pkgs, ...}: let
  # 1. Define the smart launcher script for QQ
  qq-launcher = pkgs.writeShellScriptBin "launch-qq.sh" ''
    #!/bin/sh
    # Define the name for our persistent container
    CONTAINER_NAME="qq-persistent"

    # Ensure the host directory for QQ's config exists
    mkdir -p "$HOME/.config/qq-docker"

    # Check if the container is already running
    if [ "$(${pkgs.docker}/bin/docker ps -q -f name=$CONTAINER_NAME)" ]; then
        echo "Container is running. Sending activation signal via D-Bus..."
        # This command asks the QQ application's D-Bus service to execute its 'show' method.
        # The service name and path are educated guesses based on common Qt app behavior.
        ${pkgs.docker}/bin/docker exec --user user "$CONTAINER_NAME" \
            qdbus com.tencent.QQ /MainApplication show
        exit 0
    fi

    # Check if the container exists but is stopped
    if [ "$(${pkgs.docker}/bin/docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
        # If stopped, just start it
        echo "Starting existing, stopped QQ container..."
        ${pkgs.docker}/bin/docker start "$CONTAINER_NAME"
        exit 0
    fi

    # If the container does not exist at all, create it for the first time
    echo "Container not found. Creating and starting new QQ container..."
    ${pkgs.docker}/bin/docker run \
        -d \
        --name "$CONTAINER_NAME" \
        --user $(id -u):$(id -g) \
        --network=default \
        -e DISPLAY \
        -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
        -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
        -e QT_QPA_PLATFORM=wayland \
        -e DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS \
        -e GTK_IM_MODULE=fcitx \
        -e QT_IM_MODULE=fcitx \
        -e XMODIFIERS=@im=fcitx \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY=$DISPLAY \
        -e XDG_SESSION_TYPE=wayland \
        --ipc=host \
        -v "$HOME/.config/qq-docker:/home/user/.config" \
        -v "$XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR:rw" \
        -v "/dev/dri:/dev/dri:rw" \
        -v "$HOME/xdg-open-proxy:/usr/bin/xdg-open:ro" \
        -v "/etc/machine-id:/etc/machine-id:ro" \
        --security-opt="no-new-privileges" \
        --cap-drop="ALL" \
        qq-isolated
  '';
in {
  home.packages = [qq-launcher];
  xdg.desktopEntries = {
    # 2. Declaratively create the .desktop file
    "qq-docker" = {
      name = "QQ (Docker)";
      comment = "Run QQ inside a secure Docker container";
      exec = "launch-qq.sh";
      type = "Application";
    };

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
