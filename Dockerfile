FROM maven:3.6.0-jdk-8-slim AS build-stage
COPY . /project
WORKDIR /project/
RUN mvn clean package


RUN mkdir -p /config/apps && \
    mkdir -p /sharedlibs && \
    cp ./src/main/liberty/config/server.xml /config && \
    cp ./target/*.*ar /config/apps/ && \
    if [ ! -z "$(ls ./src/main/liberty/lib)" ]; then \
    cp ./src/main/liberty/lib/* /sharedlibs; \
    fi

FROM ibmcom/websphere-liberty:kernel-java8-ibmjava-ubi

ARG SSL=false
ARG MP_MONITORING=false
ARG HTTP_ENDPOINT=false

RUN mkdir -p /opt/ol/wlp/usr/shared/config/lib/global
COPY --chown=1001:0 --from=build-stage /config/ /config/
COPY --chown=1001:0 --from=build-stage /sharedlibs/ /opt/ol/wlp/usr/shared/config/lib/global

RUN configure.sh

# Upgrade to production license if URL to JAR provided
ARG LICENSE_JAR_URL
RUN \
    if [ $LICENSE_JAR_URL ]; then \
    wget $LICENSE_JAR_URL -O /tmp/license.jar \
    && java -jar /tmp/license.jar -acceptLicense /opt/ibm \
    && rm /tmp/license.jar; \
    fi
