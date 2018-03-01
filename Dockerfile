FROM fluent/fluentd:v1.1.0

RUN apk add --update --virtual .build-deps \
    sudo build-base ruby-dev

RUN sudo gem install fluent-plugin-elasticsearch -v 2.5.0 \
    && sudo gem install fluent-plugin-concat -v 2.1.0 \
    && sudo gem install fluent-plugin-rewrite-tag-filter -v 2.0.2 \
    && sudo gem install fluent-plugin-kafka -v 0.6.3 \
    && sudo gem install fluent-plugin-cadvisor -v 0.3.1 \
    && sudo gem install fluent-plugin-flowcounter -v 1.3 \
    && sudo gem install fluent-plugin-ignore-filter -v 2.0.0 \
    && sudo gem sources --clear-all \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* \
        /home/fluent/.gem/ruby/2.3.0/cache/*.gem

RUN mkdir -p /data/log/td-agent/buffer/ \
    && chmod -R 777 /data/log/td-agent/buffer

COPY fluent.conf /fluentd/etc/
ENV FLUENTD_CONF="fluent.conf"
