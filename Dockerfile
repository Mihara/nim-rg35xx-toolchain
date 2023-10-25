FROM docker.io/aveferrum/rg35xx-toolchain AS toolchain-source

# Add a few extra packages and install Nim with choosenim
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y curl xz-utils gcc openssl ca-certificates git && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    curl https://nim-lang.org/choosenim/init.sh -sSf | bash -s -- -y && \
    git config --global --add safe.directory /root/workspace

# Add Nim to path too.
ENV PATH=/root/.nimble/bin:$PATH

WORKDIR /root/workspace/

CMD ["/bin/bash"]
