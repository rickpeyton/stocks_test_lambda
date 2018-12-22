FROM lambci/lambda:build-ruby2.5 as develop
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . ./

FROM lambci/lambda:build-ruby2.5 as deploy
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
RUN bundle install --deployment --without test
COPY . ./
ENTRYPOINT ["ruby", "/app/deploy.rb"]
