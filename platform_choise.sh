#!/bin/sh

set -xe

case "${TARGETPLATFORM}" in
    ""|"linux/amd64") # default
        PLATFORM="linux"
        ARCH="64"
    ;;
    "linux/386")
        PLATFORM="linux"
        ARCH="32"
    ;;
    "linux/arm/v5")
        PLATFORM="linux"
        ARCH="arm32-v5"
        ;;
    "linux/arm/v6")
        PLATFORM="linux"
        ARCH="arm32-v6"
        ;;
    "linux/arm/v7")
        PLATFORM="linux"
        ARCH="arm32-v7a"
        ;;
    "linux/arm64"|"linux/arm64/v8")
        PLATFORM="linux"
        ARCH="arm64-v8a"
        ;;
    "linux/loong64")
        PLATFORM="linux"
        ARCH="loong64"
        ;;
    "linux/ppc64le")
        PLATFORM="linux"
        ARCH="ppc64le"
        ;;
    "linux/s390x")
        PLATFORM="linux"
        ARCH="s390x"
        ;;
    "linux/riscv64")
        PLATFORM="linux"
        ARCH="s390x"
        ;;
    "linux/mips64le")
        PLATFORM="linux"
        ARCH="mips64le"
        ;;
esac

[ -z "${PLATFORM}" -o -z "${ARCH}" ] && echo "Unsupport Platform: ${TARGETPLATFORM}" && exit 1
[ -z "${XRAY_VERSION}" ] && echo "\$XRAY_VERSION required!" && exit 1

mkdir -p /var/cache/xray/${XRAY_VERSION}

wget -c -P /var/cache/xray/${XRAY_VERSION} \
    https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-${PLATFORM}-${ARCH}.zip\
    https://github.com/XTLS/Xray-core/releases/download/v${XRAY_VERSION}/Xray-${PLATFORM}-${ARCH}.zip.dgst
grep 'SHA2-512=' /var/cache/xray/${XRAY_VERSION}/Xray-${PLATFORM}-${ARCH}.zip.dgst | cut -d' ' -f2 > /var/cache/xray/${XRAY_VERSION}/${PLATFORM}-${ARCH}.dgst.sha512
sha512sum /var/cache/xray/${XRAY_VERSION}/Xray-${PLATFORM}-${ARCH}.zip | cut -d' ' -f1 | diff -u /var/cache/xray/${XRAY_VERSION}/${PLATFORM}-${ARCH}.dgst.sha512 -
mv /var/cache/xray/${XRAY_VERSION}/Xray-${PLATFORM}-${ARCH}.zip Xray.zip