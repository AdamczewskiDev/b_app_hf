#!/bin/bash
set -e

# Usuń istniejący plik server.pid, jeśli istnieje
rm -f /app/tmp/pids/server.pid

# Uruchom główny proces kontenera
exec "$@"