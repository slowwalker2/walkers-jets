FROM ruby:2.5.3

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update -qq && \
    apt-get install -y \
      build-essential \
      libpq-dev \
      nodejs \
      vim \
      zip \
      unzip \
      rsync \
      --no-install-recommends && \
      rm -rf /var/lib/apt/lists/*
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH="/root/.yarn/bin:$PATH"
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --system

COPY . ./

RUN jets webpacker:install

EXPOSE 8888
CMD ["jets", "server", "--host", "0.0.0.0"]

