FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN set -ex; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        ubuntu-desktop \
        unity-lens-applications \
        gnome-panel \
        metacity \
        nautilus \
        gedit \
        xterm \
        sudo \
	    firefox \
        bash \
        net-tools \
        novnc \
        socat \
        x11vnc \
        gnome-panel \
        gnome-terminal \
        xvfb \
        supervisor \
        net-tools \
        curl \
        git \
	    wget \
        libtasn1-3-bin \
        libglu1-mesa \
        libqt5webkit5 \
        libqt5x11extras5 \
        qml-module-qtquick-controls \
        qml-module-qtquick-dialogs \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*
    
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN sudo dpkg --install google-chrome-stable_current_amd64.deb
RUN sudo apt install --assume-yes --fix-broken
RUN sudo apt-get install gdebi
RUN sudo apt-get install -f

ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1366 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=yes \
    RUN_UNITY=yes

RUN adduser ubuntu

RUN echo "John:2001" | chpasswd && \
    adduser John sudo && \
    sudo usermod -a -G sudo John

RUN wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb && apt install ./teamviewer_amd64.deb

RUN sudo add-apt-repository ppa:obsproject/obs-studio \
     && sudo apt-get update && sudo apt-get install -y obs-studio

COPY . /app

RUN chmod +x /app/conf.d/websockify.sh
RUN chmod +x /app/run.sh
USER ubuntu

CMD ["/app/run.sh"]
