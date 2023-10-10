FROM ruby:3.1.2

ENV WRKDIR=lapras

RUN apt-get update -qq && apt-get install

RUN mkdir /${WRKDIR}

WORKDIR /${WRKDIR}

COPY ./Gemfile /${WRKDIR}/Gemfile
COPY Gemfile.lock /${WRKDIR}/Gemfile.lock

RUN bundle install

COPY . /${WRKDIR}