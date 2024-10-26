FROM debian:bullseye-20241016-slim
ARG DEBIAN_FRONTEND=noninteractive
ARG OPENJDK_VERSION=432
ARG OPENJDK_SUBVERSION=b06
RUN sed -i 's/main/main contrib non-free/' /etc/apt/sources.list
RUN apt-get update && \
    apt-get -yqu dist-upgrade && \
    apt-get -yq install wget && \
    wget -q https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u$OPENJDK_VERSION-$OPENJDK_SUBVERSION/OpenJDK8U-jre_x64_linux_hotspot_8u$OPENJDK_VERSION$OPENJDK_SUBVERSION.tar.gz && \
    wget -O- -q -T 1 -t 1 https://github.com/adoptium/temurin8-binaries/releases/download/jdk8u$OPENJDK_VERSION-$OPENJDK_SUBVERSION/OpenJDK8U-jre_x64_linux_hotspot_8u$OPENJDK_VERSION$OPENJDK_SUBVERSION.tar.gz.sha256.txt | sha256sum -c && \
    mkdir -p /opt/jdk8u-jre && \
    tar -xf OpenJDK8U-jre_x64_linux_hotspot_8u$OPENJDK_VERSION$OPENJDK_SUBVERSION.tar.gz -C /opt/jdk8u-jre --strip-components 1 && \
    rm OpenJDK8U-jre_x64_linux_hotspot_8u$OPENJDK_VERSION$OPENJDK_SUBVERSION.tar.gz && \
    apt-get -yq autoremove && \
    apt-get clean && \
    rm -rf /var/lib/{apt,dpkg,cache,log}
ENV PATH=/opt/jdk8u-jre/bin:$PATH
WORKDIR /app
CMD ["java", "-version"]
