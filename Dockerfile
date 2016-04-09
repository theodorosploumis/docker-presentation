FROM nimmis/alpine-apache
MAINTAINER Theodoros Ploumis <me@theodorosploumis.com>

# Add the whole repo.
ADD . /web/html

# Set this as initial path when ssh logging.
WORKDIR /web/html
