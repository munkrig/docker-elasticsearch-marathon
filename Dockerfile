FROM tobilg/elasticsearch:latest

RUN apt-get -y update
RUN apt-get -y install curl
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN apt-get install -y nodejs

RUN /elasticsearch/bin/plugin -install royrusso/elasticsearch-HQ
RUN echo "http.cors.enabled: true" >> /elasticsearch/config/elasticsearch.yml
RUN echo "script.disable_dynamic: false" >> /elasticsearch/config/elasticsearch.yml

ADD ./elasticsearch-marathon-bootstrap.sh /usr/local/bin/
ADD ./elasticsearches.js /usr/local/bin/

RUN chmod +x /usr/local/bin/elasticsearches.js

CMD "/usr/local/bin/elasticsearch-marathon-bootstrap.sh"
