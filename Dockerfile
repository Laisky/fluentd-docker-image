FROM fluent/fluentd
MAINTAINER Laisky <ppcelery@gmail.com>
LABEL Description="Fluentd docker image" Vendor="Fluent Organization" Version="1.1.1"

# Install mongo match plugin
# http://docs.fluentd.org/articles/out_mongo
RUN fluent-gem install fluent-plugin-mongo
