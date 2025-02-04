FROM alpine:latest AS baseimg

RUN --mount=type=cache,target=/var/cache\
    set -xe\
 && apk add --no-cache tzdata ca-certificates

FROM baseimg AS downloader

ADD platform_choise.sh /
ARG XRAY_VERSION
ARG TARGETPLATFORM
ARG BUILDPLATFORM
RUN --mount=type=cache,target=/var/cache\
    set -xe\
 && apk add --no-cache wget\
 && mkdir -p /var/log/xray /usr/share/xray\
 && sh platform_choise.sh\
 && mkdir -p src\
 && cd src\
 && unzip -o ../Xray.zip\
 && chmod +x xray\
 && mkdir -p /fakeroot/usr/share/xray/ /fakeroot/usr/bin/ /fakeroot/etc/xray/\
 && mv -v xray /fakeroot/usr/bin/xray\
 && mv -v geosite.dat geoip.dat /fakeroot/usr/share/xray/

FROM baseimg
COPY --from=downloader /fakeroot/ /
VOLUME /etc/xray
ENV TZ=Asia/Shanghai
CMD [ "/usr/bin/xray", "run", "-config", "/etc/xray/config.json" ]