ARG IMAGE=store/intersystems/iris-community:2021.2.0.617.0
FROM $IMAGE

USER root   

WORKDIR /opt/irisbuild
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisbuild
USER ${ISC_PACKAGE_MGRUSER}

COPY data data
COPY ddl ddl
COPY iris.script iris.script

ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
RUN iris start IRIS && iris session IRIS < iris.script && iris stop IRIS quietly