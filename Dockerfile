# Użyj oficjalnego obrazu Ruby
FROM ruby:3.0

# Zainstaluj zależności systemowe
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Ustaw zmienną środowiskową dla katalogu aplikacji
ENV INSTALL_PATH /app
RUN mkdir -p $INSTALL_PATH

# Zmień katalog roboczy
WORKDIR $INSTALL_PATH

# Skopiuj Gemfile i Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Zainstaluj zależności Ruby
RUN gem install bundler && bundle install

# Skopiuj resztę aplikacji
COPY . .

# Dodaj skrypt do uruchamiania kontenera
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Uruchom serwer Rails
CMD ["rails", "server", "-b", "0.0.0.0"]