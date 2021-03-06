FROM mariadb:latest
MAINTAINER Yanis LISIMA <zeenlym@gmail.com>
MAINTAINER N3xtcoder developers <dev@n3xtcoder.org>
MAINTAINER Joel Bernstein <joel@fysh.org>

# Setting bash as default shell
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install dependencies
RUN apt-get -y update \
    && LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        curl \
        p7zip \
        python3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Getting go-cron
ENV GO_CRON_VERSION v0.0.7

RUN curl -L https://github.com/odise/go-cron/releases/download/${GO_CRON_VERSION}/go-cron-linux.gz \
        | zcat > /usr/local/bin/go-cron \
    && chmod u+x /usr/local/bin/go-cron

COPY mdbtool /usr/local/mdbtool
COPY bin/* /usr/local/bin/

RUN ln -s /usr/local/mdbtool/mdbtool /usr/local/bin

COPY docker-entrypoint.sh /usr/local/bin/new-entrypoint.sh
COPY initdb/* /docker-entrypoint-initdb.d/


EXPOSE 18080

VOLUME /backup

ENTRYPOINT ["new-entrypoint.sh"]

CMD ["go-cron"]

