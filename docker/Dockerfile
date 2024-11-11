ARG UBUNTU=22.04
FROM ubuntu:${UBUNTU}

ARG UID=1000
ARG GID=1000
ARG GROUPNAME=ubuntu
ARG USERNAME=ubuntu
ARG NOVNC_VERSION=1.5.0

ENV MESA_GL_VERSION_OVERRIDE=4.6
ENV PRIVACY_CONSENT=Y
ENV ACCEPT_EULA=Y
ENV NVIDIA_DRIVER_CAPABILITIES=all
ENV LANG en_US.utf8


ENV UID=${UID}
ENV GID=${GID}
ENV GROUPNAME=${GROUPNAME}
ENV USERNAME=${USERNAME}

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    openbox supervisor gosu locales \
    tigervnc-standalone-server \
    websockify curl jq ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/debconf/* /var/log/* /tmp/* /var/tmp/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

RUN cd /opt && curl -Lk https://github.com/novnc/noVNC/archive/refs/tags/v${NOVNC_VERSION}.tar.gz | tar xz && \
    mv noVNC-${NOVNC_VERSION} novnc && cp /opt/novnc/vnc.html /opt/novnc/index.html

RUN cd /tmp && VIRTUALGL_VERSION="$(curl -fsSL "https://api.github.com/repos/VirtualGL/virtualgl/releases/latest" | jq -r '.tag_name' | sed 's/[^0-9\.\-]*//g')" && \
    curl -fsSL -O "https://github.com/VirtualGL/virtualgl/releases/download/${VIRTUALGL_VERSION}/virtualgl_${VIRTUALGL_VERSION}_amd64.deb" && \
    apt-get update && apt-get install -y --no-install-recommends "./virtualgl_${VIRTUALGL_VERSION}_amd64.deb" && \
    rm -f "virtualgl_${VIRTUALGL_VERSION}_amd64.deb" && \
    chmod -f u+s /usr/lib/libvglfaker.so /usr/lib/libvglfaker-nodl.so /usr/lib/libvglfaker-opencl.so /usr/lib/libdlfaker.so /usr/lib/libgefaker.so && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/debconf/* /var/log/* /tmp/* /var/tmp/*

COPY supervisord.conf /etc/
COPY start_x.sh /

RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME && \
    mkdir -p -m 777 /tmp/.X11-unix

ENTRYPOINT /start_x.sh
