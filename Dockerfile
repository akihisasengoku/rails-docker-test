
FROM ruby:2.3.1
ENV LANG C.UTF-8

# for MySQL
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev mysql-client nodejs
RUN apt-get install -y ruby-dev zlib1g-dev liblzma-dev ruby-all-dev
RUN apt-get install -y cron
RUN apt-get install -y build-essential
RUN apt-get install -y aptitude
RUN apt-get install -y libstdc++6

# rails
RUN gem install bundler

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]

