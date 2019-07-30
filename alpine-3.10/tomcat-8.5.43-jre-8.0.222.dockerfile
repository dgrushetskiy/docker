# Build:
# docker build -t devstudy/tomcat:8.5.43 -t devstudy/tomcat:8 -f ./tomcat-8.5.43-jre-8.0.222.dockerfile .
#
# Versions:
# ----------------------------------------------------------------------------------------------------------------
ARG TOMCAT8_VERSION=8.5.43
ARG JRE_VERSION=8.0.222
# ----------------------------------------------------------------------------------------------------------------
FROM devstudy/jre:${JRE_VERSION}

MAINTAINER devstudy.net

ARG TOMCAT8_VERSION
ARG TOMCAT8_FOLDER=apache-tomcat-${TOMCAT8_VERSION}
ARG TOMCAT8_DOWNLOAD_LINK=http://apache.volia.net/tomcat/tomcat-8/v${TOMCAT8_VERSION}/bin/${TOMCAT8_FOLDER}.tar.gz

RUN mkdir /opt/install && \
    cd /opt/install && \
    wget ${TOMCAT8_DOWNLOAD_LINK} && \
    tar -xzf ${TOMCAT8_FOLDER}.tar.gz && \
    mv /opt/install/${TOMCAT8_FOLDER} /opt/tomcat && \
    rm -rf /opt/install && \
    rm -rf /opt/tomcat/webapps/docs && \
    rm -rf /opt/tomcat/webapps/examples && \
    rm -rf /opt/tomcat/webapps/host-manager && \
    rm -rf /opt/tomcat/webapps/manager && \
    busybox find /opt/tomcat/bin -type f -name "*.bat" -delete

ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

EXPOSE 8080
CMD ["catalina.sh", "run"]