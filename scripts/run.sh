#!/bin/bash

set -e

source /scripts/helpers.sh
source /scripts/database.sh
source /scripts/plugins.sh
source /scripts/composer.sh

setup_database &
SETUP_PID=$!
install_dependencies &
DEPENDENDIES_PID=$!

wait $SETUP_PID
wait $DEPENDENCIES_PID
activate_plugins

wait

h2 "🧶 🐈  # Go to http://localhost:9000/admin in your browser to start using Craft CMS."

# Start php-fpm
exec "$@"
