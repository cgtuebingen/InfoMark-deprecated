FROM ruby:2.3

RUN apt-get update -qq && apt-get install -y build-essential nodejs npm nodejs-legacy mysql-client vim
RUN npm install -g phantomjs-prebuilt@2.1.15
RUN apt-get install -y python2.7 python-dev python-pip

RUN apt-get install python-pygments
RUN pip install Pygments
RUN mkdir /myapp


WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install
# # update
# RUN gem install bundler

ADD . /myapp
WORKDIR /myapp

ENV RAILS_ENV=production

ENV INFOMARK_DOMAIN_NAME=localhost
ENV SECRET_KEY_BASE=topsecret

RUN RAILS_ENV=production bundle exec rake assets:precompile --trace
# CMD ["rails","server","-b","0.0.0.0"]



