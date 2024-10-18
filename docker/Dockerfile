FROM nvcr.io/nvidia/cuda:12.6.2-base-ubuntu22.04

ARG UID=1000
ARG GID=1000
ARG GROUPNAME=ubuntu
ARG USERNAME=ubuntu

ENV DISPLAY=:10
ENV MESA_GL_VERSION_OVERRIDE=4.6
ENV PRIVACY_CONSENT=Y
ENV ACCEPT_EULA=Y

ENV UID=${UID}
ENV GID=${GID}
ENV GROUPNAME=${GROUPNAME}
ENV USERNAME=${USERNAME}

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    openbox tigervnc-standalone-server supervisor gosu \
    lxterminal xdg-utils htop mesa-utils websockify git &&\
    rm -rf /var/lib/apt/lists && \
    mkdir -p /usr/share/desktop-directories

RUN git clone https://github.com/novnc/noVNC.git /opt/novnc && \
    cd /opt/novnc && \
    git checkout v1.5.0 && \
    cp /opt/novnc/vnc.html /opt/novnc/index.html

COPY menu.xml /var/lib/openbox/debian-menu.xml
COPY supervisord.conf /etc/
COPY start_x.sh /

RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME && \
    mkdir -p /tmp/.X11-unix && chmod 777 /tmp/.X11-unix

ENTRYPOINT /start_x.sh
