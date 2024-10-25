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

Additionally, running OpenGL applications currently supported **only** in host OS sharing scenario.

By default NoVNC uses port number `6080`, however it can be modified either inside the `docker-compose.yaml` or afterwards with ssh port forwarding.

Before using apps with OpenGL, ensure that VirtualGL is installed. Take a look at the available [packages](https://github.com/VirtualGL/virtualgl/releases)

### Steps to Run the Environment

0. Copy .env.sample to .env file and modify `DISPLAY` and `WEB_PORT` to free X display and free TCP port.
1. Start the desktop container with `docker compose up -d desktop`.
2. Access it at `http://localhost:<WEB_PORT>` on your host machine.
3. If you're using SSH, set up local port forwarding and access with http://localhost:6080.

### Setting Up SSH Port Forwarding

To start a new connection, use the following command:

```bash
ssh -L 6080:localhost:<WEB_PORT> user@host
```

If you prefer to change the port on the fly within a single SSH connection, you can do this:

```bash
ssh -o "EnableEscapeCommandline yes" user@host

# After discovering the port:
#  Press <return>
#  Type "~C" (tilde + shift + c)
#  The "ssh>" prompt will appear
#  Enter "-L 6080:localhost:<port>" and press enter
#
#  You can then access the application via http://localhost:<port>
```


### Embedding in the docker-compose.yaml example 

Add the following piece of code to your docker-compose file

```yaml
  desktop:
    image: ghcr.io/matsuolab/virtual_desktop:latest
    runtime: nvidia
    environment:
      - NVIDIA_VISIBLE_DEVICES=all
      - NVIDIA_DRIVER_CAPABILITIES=all
      - DISPLAY
    ports:
      - "${WEB_PORT}:6080"
    volumes: 
      - "/tmp/.X11-unix:/tmp/.X11-unix:rw"
    security_opt:
      - seccomp:unconfined
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: all
              capabilities: [gpu]
  <your_service>:
    depends_on:
      - desktop
    volumes: 
      - "/tmp/.X11-unix:/tmp/.X11-unix:rw"
    environment:
      - NVIDIA_VISIBLE_DEVICES=all
      - NVIDIA_DRIVER_CAPABILITIES=all
      - DISPLAY
```

### Connecting other services with docker-compose
Modify your docker-compose or .env file if needed.

```yaml
  <your_service>:
    depends_on:
      - desktop
    volumes: 
      - "/tmp/.X11-unix:/tmp/.X11-unix:rw"
    environment:
      - NVIDIA_VISIBLE_DEVICES=all
      - NVIDIA_DRIVER_CAPABILITIES=all
      - DISPLAY
```

Don't forget to install VirtualGL if needed and execute your app with `vglrun` prefix (e.g. `vglrun application`).

### Run with docker command

```bash
docker run ... -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=... image
```

### Run simple application from host OS

Define the DISPLAY to match the one of virtual display.

```bash
DISPLAY=... vglrun glxgears
```
