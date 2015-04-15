FROM wmarinho/ubuntu:oracle-jdk-7

MAINTAINER Dlani Leonardo dlanileonardo@gmail.com

# Init ENV
ENV BISERVER_TAG 5.3.0.0-213

ENV PENTAHO_HOME /opt/pentaho

# Apply JAVA_HOME
RUN . /etc/environment
ENV PENTAHO_JAVA_HOME $JAVA_HOME

RUN apt-get update \
    && apt-get install wget unzip git -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Download Pentaho BI Server
RUN /usr/bin/wget -nv http://downloads.sourceforge.net/project/pentaho/Data%20Integration/5.3/pdi-ce-${BISERVER_TAG}.zip -O /tmp/pdi-ce-${BISERVER_TAG}.zip

RUN  /usr/bin/unzip -q /tmp/pdi-ce-${BISERVER_TAG}.zip -d  $PENTAHO_HOME &&\
     rm /tmp/pdi-ce-${BISERVER_TAG}.zip

COPY scripts $PENTAHO_HOME/scripts
COPY scripts/run.sh /

EXPOSE 8080
CMD ["/run.sh"]