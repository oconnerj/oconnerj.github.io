FROM ubuntu:noble as rb

RUN apt update && apt install -y ruby-full build-essential zlib1g-dev
RUN gem install jekyll bundler

FROM rb as bundled

WORKDIR /site
COPY _config.yml ./
COPY Gemfile ./

RUN bundle install

FROM bundled as runtime

WORKDIR /site
COPY _includes/ ./_includes/
COPY _layouts/ ./_layouts/
COPY _posts/ ./_posts/
COPY _sass/ ./_sass/
COPY assets/ ./assets/
COPY category/ ./category/
COPY images/ ./images/
COPY games/ ./games/
COPY *.* ./
COPY CNAME ./

EXPOSE 4000
ENTRYPOINT ["bundle", "exec", "jekyll", "serve"]