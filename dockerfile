ARG IMAGE=containers.intersystems.com/intersystems/iris-community:latest-cd
#ARG IMAGE=containers.intersystems.com/intersystems/iris-community:latest-preview
FROM $IMAGE

USER root   

WORKDIR /opt/irisbuild
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild
USER ${ISC_PACKAGE_MGRUSER}

COPY data data
COPY src src
COPY doc doc
COPY iris.script iris.script

ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
RUN iris start IRIS && iris session IRIS < iris.script && iris stop IRIS quietly