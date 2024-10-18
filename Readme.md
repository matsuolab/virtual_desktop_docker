# RDP Docker Image

This image offers a minimal toolset for running GUI applications within an isolated X11 environment.

## Features

Out of the box, it includes:

* A lightweight desktop environment (openbox)
* VNC server (TigerVNC)
* NoVNC proxy server

## How to Use

Your usage will depend on **where** you intend to launch the GUI application. The key idea is to share the `.X11-unix` folder.

There are two primary scenarios: sharing `.X11-unix` with the host OS or using a Docker volume to store it. Generally, the **latter** is recommended to avoid potential X server conflicts.

However, if you choose to share the directory with the host OS, you'll benefit from being able to run UI applications from the desktop within the virtual environment.

Once the `rdp` Docker container is running, you can access it at [http://localhost:6080](http://localhost:6080).

If you're using SSH, you can set up local port forwarding with:

```bash
ssh -L 6080:localhost:6080 user@host
```

**Additional Note:** If you want to use a custom port and aren’t sure what it is, follow these steps:

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
