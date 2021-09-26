FROM ubuntu:20.04

# install dependencies
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ninja-build \
    gperf \
    ccache \
    dfu-util \
    device-tree-compiler \
    wget \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-tk \
    python3-wheel \
    xz-utils \
    file \
    make \
    gcc \
    gcc-multilib \
    g++-multilib \
    libsdl2-dev \
    doxygen \
 && rm -rf /var/lib/apt/lists/*

# install recent CMake
RUN pip3 install cmake

# install SDK
ARG ZSDK_TOOL=toolchain-arm
ARG ZSDK_VERSION=0.13.1
RUN wget -q "https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZSDK_VERSION}/zephyr-${ZSDK_TOOL}-${ZSDK_VERSION}-linux-x86_64-setup.run" && \
    sh "zephyr-${ZSDK_TOOL}-${ZSDK_VERSION}-linux-x86_64-setup.run" --quiet -- -d /opt/toolchains/zephyr-${ZSDK_TOOL}-${ZSDK_VERSION} && \
    rm "zephyr-${ZSDK_TOOL}-${ZSDK_VERSION}-linux-x86_64-setup.run"

ENV ZEPHYR_TOOLCHAIN_VARIANT=zephyr
ENV ZEPHYR_SDK_INSTALL_DIR=/opt/toolchains/zephyr-${ZSDK_TOOL}-${ZSDK_VERSION}

# install West
RUN pip3 install west
