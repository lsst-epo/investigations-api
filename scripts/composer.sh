declare DEPENDENCIES=(${DEPENDENCIES//,/ })
declare AUTO_UPDATE=${AUTO_UPDATE:-true}

install_dependencies() {
    cd /var/www/html/api

    h2 'Installing composer dependencies.'
    composer install

    h2 '✅  All dependencies successfully installed.'
}
