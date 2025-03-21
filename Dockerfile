FROM ghcr.io/open-webui/open-webui:git-e6ff416-cuda

# Copy manually extracted libz files into the container
#COPY libz.so.1 /usr/lib/x86_64-linux-gnu/libz.so.1
#COPY libz.so.1.2.13 /usr/lib/x86_64-linux-gnu/libz.so.1.2.13

# Perform package removals
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
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Upgrade Jinja2 to patch CVEs
RUN pip install --no-cache-dir --upgrade "Jinja2>=3.1.6"

# WARNING: This will uninstall the package manager, which will prevent us from removing other packages, so this should be done last
RUN dpkg --purge --force-all zlib1g

# Copy manually extracted libz files into the container
COPY libz.so.1 /usr/lib/x86_64-linux-gnu/libz.so.1
COPY libz.so.1.2.13 /usr/lib/x86_64-linux-gnu/libz.so.1.2.13
