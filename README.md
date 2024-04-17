# Docker-Xray
将[xray](https://github.com/XTLS/Xray-core)原封不动打包到docker

<a href="//hub.docker.com/r/boringcat/xray" target="_blank">![stars](https://img.shields.io/docker/stars/boringcat/xray.svg)</a>
<a href="//hub.docker.com/r/boringcat/xray" target="_blank">![pulls](https://img.shields.io/docker/pulls/boringcat/xray.svg)</a>
<a href="//github.com/boringcat/docker-xray" target="_blank">![github](https://img.shields.io/github/stars/boringcat/docker-xray.svg)</a>

## Docker Build
```sh
export XRAY_VERSION=1.8.10
docker buildx build --pull --push\
    --builder multiplatform \
    --platform linux/amd64,linux/386,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/s390x \
    --build-arg XRAY_VERSION=${XRAY_VERSION} \
    -t boringcat/xray:${XRAY_VERSION} .
```
