## ⚠️注意⚠️：Xray已提供官方Docker镜像，本项目将归档
### 一些问题
- Q: 官方镜像如何清理OOM残留的UnixSocket文件  
  A: 官方镜像使用 gcr.io/distroless/static:nonroot 打包，默认无shell环境  
    可以使用 docker-compose 的 depends_on 方法，在容器启动前执行shell  
  ```yaml
  services:
    proxy-clean:
      image: alpine
      entrypoint: [/bin/sh, -c]
      command:
        - |-
          set -euo pipefile
          chown -R 65532:65532 /var/run
          chmod 1777 /var/run
          find /var/run -name '*.sock' -delete
      volumes:
        - xray-sock:/var/run

    proxy:
      ...
      depends_on:
        proxy-clean:
          condition: service_completed_successfully
      ...
  ```

# Docker-Xray
将[xray](https://github.com/XTLS/Xray-core)原封不动打包到docker

<a href="//github.com/BoringCat/docker-xray/actions/workflows/docker-build.yml" target="_blank">![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/BoringCat/docker-xray/docker-build.yml)</a>
<a href="//hub.docker.com/r/boringcat/xray" target="_blank">![stars](https://img.shields.io/docker/stars/boringcat/xray.svg)</a>
<a href="//hub.docker.com/r/boringcat/xray" target="_blank">![pulls](https://img.shields.io/docker/pulls/boringcat/xray.svg)</a>
<a href="//github.com/boringcat/docker-xray" target="_blank">![github](https://img.shields.io/github/stars/boringcat/docker-xray.svg)</a>

## Docker Build
```sh
export XRAY_VERSION=25.10.15
docker buildx build --pull --push\
    --builder multiplatform \
    --platform linux/amd64,linux/386,linux/arm/v6,linux/arm/v7,linux/arm64,linux/ppc64le,linux/s390x \
    --build-arg XRAY_VERSION=${XRAY_VERSION} \
    -t boringcat/xray:${XRAY_VERSION} .
```
