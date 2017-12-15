FROM ruby:2.3

RUN apt-get update -qq && apt-get install -y build-essential nodejs npm nodejs-legacy mysql-client vim
RUN npm install -g phantomjs-prebuilt@2.1.15

RUN mkdir /myapp


WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install

ADD . /myapp
WORKDIR /myapp

ENV INFOMARK_DOMAIN_NAME=localhost
ENV RAILS_ENV=production
ENV SECRET_KEY_BASE=topsecret

RUN RAILS_ENV=production bundle exec rake assets:precompile --trace
# CMD ["rails","server","-b","0.0.0.0"]



