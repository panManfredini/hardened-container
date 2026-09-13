podman create  --init --name devbox   --network=bridge --hostname devbox --userns=keep-id  --user dev:dev --security-opt label=type:devbox.process --volume $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY  -v $XDG_RUNTIME_DIR/bus:$XDG_RUNTIME_DIR/bus:ro  --device /dev/dri   --volume /dev/dri:/dev/dri:ro   --env WAYLAND_DISPLAY=$WAYLAND_DISPLAY   --env XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR   --env XDG_SESSION_TYPE=wayland  --shm-size=2g  --volume /home/$USER/Work:/home/dev/workspace:Z fedora-wayland:latest  sleep infinity

podman start devbox
podman exec -it devbox bash
