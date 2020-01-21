FROM aeris22/cryptcheck AS builder
MAINTAINER Alexandre Flament <alex@al-f.net>

RUN apk add --update bash make gcc g++ libxml2-dev yaml-dev zlib-dev

ENV PATH /usr/local/rbenv/shims:/usr/local/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/rbenv
ENV RUBY_CONFIGURE_OPTS --disable-install-doc

WORKDIR /cryptcheck-backend/
COPY .ruby-version Gemfile /cryptcheck-backend/

RUN bundle config --local local.cryptcheck /cryptcheck && \
    bundle config set without 'test development'
RUN bundle install
RUN bundle config set deployment 'true' && \
    bundle install

COPY . /cryptcheck-backend/

FROM aeris22/cryptcheck AS server
MAINTAINER Alexandre Flament <alex@al-f.net>

RUN apk add --no-cache --update libstdc++

ENV RAILS_ENV=production
ENV SINATRA_ACTIVESUPPORT_WARNING false

WORKDIR /cryptcheck-backend/
COPY --from=builder /cryptcheck-backend/ /cryptcheck-backend/

EXPOSE 7000

ENTRYPOINT ["/sbin/tini", "--", "/cryptcheck-backend/cryptcheck-backend"]

LABEL org.label-schema.usage="https://github.com/dalf/cryptcheck-backend" \
      org.opencontainers.image.title="cryptcheck-backend" \
      org.opencontainers.image.source="git@github.com:dalf/cryptcheck-backend.git" \
      org.opencontainers.image.documentation="https://github.com/dalf/cryptcheck-backend"
