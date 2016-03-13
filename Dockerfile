FROM alpine:latest
MAINTAINER Laisky <ppcelery@gmail.com>
LABEL Description="Fluentd docker image" Vendor="Fluent Organization" Version="1.1.1"

RUN apk --no-cache --update add \
                            build-base \
                            ca-certificates \
                            ruby \
                            ruby-irb \
                            ruby-dev && \
    echo 'gem: --no-document' >> /etc/gemrc && \
    gem install fluentd -v 0.12.21 && \
    gem install fluent-plugin-mongo && \
    gem install bson_ext && \
    apk del build-base ruby-dev && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

RUN mkdir -p /fluentd/log /fluentd/etc /fluentd/plugins && \
    echo "gem: --user-install --no-document" >> ~/.gemrc

ENV PATH /.gem/ruby/2.2.0/bin:$PATH && \
    GEM_PATH /.gem/ruby/2.2.0:$GEM_PATH

COPY fluent.conf /fluentd/etc/
ONBUILD COPY fluent.conf /fluentd/etc/
ONBUILD COPY plugins /fluentd/plugins/

ENV FLUENTD_OPT=""
ENV FLUENTD_CONF="fluent.conf"

EXPOSE 24224

CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
