
Policy:
- I don't need GPU acceleration, neither matplotlib, nor vscode, nor eog use it. So remove the device dri access, for additional security.
- Add a proxy for DBUS, vscode and eog are already sandboxed with bubblewrap, so they need DBUS for access to files. Make a proxy with xdg-dbus-proxy with limited capabilities, probably just file picker, have the xdg-dbus-proxy socket labeled with selinux, and allow the container that label only.
   - definitions here: https://flatpak.github.io/xdg-desktop-portal/docs/api-reference.html 
- ssh: use ssh-agent -c and add a GUI proxy to ask for user confirmation, use ssh-askpass:
  - sudo dnf install openssh-askpass
  - export SSH_ASKPASS="/usr/libexec/openssh/ssh-askpass"
  - export SSH_ASKPASS_REQUIRE="prefer" # Force the agent to always use the GUI (askpass) even if not available, not working, etc.
- wayiland proxy: way-secure, this is an Arch package, I can make a container with low permission (no-network, etc) and use it to run this proxy for all my container to get wayland access, 
                  I can even SELinux the socket, such that those container only get filtered access to wayland socket. Basically sway should promt a message if I try to do a screenshot from there, but 
                  need to see what flag to configure.

