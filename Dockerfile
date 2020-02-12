#FROM confluentinc/cp-base
FROM maven:3.6-jdk-11-openj9

WORKDIR /
RUN apt update && apt upgrade -y
RUN apt install -y git

RUN git clone https://github.com/confluentinc/kafka
WORKDIR /kafka
RUN ./gradlew installAll

WORKDIR /
RUN git clone https://github.com/confluentinc/common
WORKDIR /common
RUN mvn install

WORKDIR /
RUN git clone https://github.com/confluentinc/rest-utils
WORKDIR /rest-utils
RUN mvn install

ADD . /schema-registry
WORKDIR /schema-registry
RUN mvn clean package

EXPOSE 8081

CMD ["./bin/schema-registry-start","config/schema-registry.properties"]
