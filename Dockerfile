FROM ghcr.io/open-webui/open-webui:git-e6ff416-cuda

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y libexpat1 && \
    DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y libharfbuzz0b && \
    DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y libldap-2.5-0 && \
    DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y libmbedcrypto7 && \
    DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y libperl5.36 && \
    DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y libsndfile1 && \
    DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y libtiff6 && \
    DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y libxml2 && \
    DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y linux-libc-dev && \
    DEBIAN_FRONTEND=noninteractive apt-get remove --purge --allow-remove-essential -y perl-base && \
    DEBIAN_FRONTEND=noninteractive apt-get remove --purge -y perl-modules-5.36 && \
    pip uninstall -y Jinja2 && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

#RUN dpkg --purge --force-all zlib1g
