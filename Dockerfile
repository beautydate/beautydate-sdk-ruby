FROM ruby:2.5.0
MAINTAINER ti@beautydate.com

RUN gem install bundler

RUN mkdir /gem
WORKDIR /gem

COPY Gemfile* /gem/
COPY *.gemspec /gem/
COPY lib /gem/lib/
ENV GEM_NAME beautydate_api

RUN bundle install

# Uncomment this line if not mounting a volume
# COPY . /gem

CMD ["bin/console"]
