FROM openjdk:8-jre-alpine

ENV TRACCAR_VERSION 4.6

WORKDIR /opt/traccar

RUN set -ex && \
    apk add --no-cache --no-progress wget && \
    wget -qO /tmp/traccar.zip https://github.com/traccar/traccar/releases/download/v$TRACCAR_VERSION/traccar-other-$TRACCAR_V$
    unzip -qo /tmp/traccar.zip -d /opt/traccar && \
    rm /tmp/traccar.zip && \
    apk del wget

ENTRYPOINT ["java", "-Xms256m", "-Xmx512m", "-Djava.net.preferIPv4Stack=true"]

CMD ["-jar", "tracker-server.jar", "conf/traccar.xml"]
