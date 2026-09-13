podman create  --init --name minimal   --network=bridge --hostname devbox --userns=keep-id  --user dev:dev  fedora-wayland:latest  sleep infinity

podman start minimal
#podman exec -it dev_s bash
