# RDP Docker Image

This image offers a minimal toolset for running GUI applications within an isolated X11 environment.
The image is intended to be used on the machines with the NVIDIA GPU.

## Features

Out of the box, it includes:

* A lightweight desktop environment (openbox)
* VNC server (TigerVNC)
* NoVNC proxy server

## How to Use

Your usage will depend on **where** you intend to launch the GUI application. The key idea is to share the `.X11-unix` folder.

There are two primary scenarios: sharing `.X11-unix` with the host OS or using a Docker volume to store it. Generally, the **latter** is recommended to avoid potential X server conflicts.

However, if you choose to share the directory with the host OS, you'll benefit from being able to run UI applications from the desktop within the virtual environment.

### Steps to Run the Environment

1. Start the desktop container with docker compose up -d desktop.
2. Check the NoVNC port using docker compose port desktop 6080 (this will output 0.0.0.0:<port>).
4. Access it at http://localhost:<port> on your host machine.
5. If you're using SSH, set up local port forwarding and access with http://localhost:6080.

### Setting Up SSH Port Forwarding

To start a new connection, use the following command:

```bash
ssh -L 6080:localhost:<port> user@host
```

If you prefer to change the port on the fly within a single SSH connection, you can do this:

```bash
ssh -o "EnableEscapeCommandline yes" user@host

# After discovering the port:
#  Press <return>
#  Type "~C" (tilde + shift + c)
#  The "ssh>" prompt will appear
#  Enter "-L <port>:localhost:<port>" and press enter
#
#  You can then access the application via http://localhost:<port>
```

### Use cases

#### [Docker] run from the same docker-compose.yaml

#### [Docker] run from different docker-compose.yaml

#### [Docker] run with docker command

#### [Host OS] run simple application

#### [Host OS] run other gnome application (firefox, etc)
