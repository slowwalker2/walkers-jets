FROM ruby:2.5.3

RUN apt-get update -qq && \
    apt-get install -y \
      build-essential \
      libpq-dev \
      vim \
      zip \
      unzip \
      rsync \
      --no-install-recommends && \
      rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 1.17.3 && bundle install --system

COPY . ./

EXPOSE 8888
CMD ["jets", "server", "--host", "0.0.0.0"]

