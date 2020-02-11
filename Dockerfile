FROM confluentinc/cp-base

ADD . /schema-registry
WORKDIR /schema-registry

EXPOSE 8081

CMD ["./bin/schema-registry-start","config/schema-registry.properties"]
