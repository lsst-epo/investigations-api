ARG BASE_TAG=latest
# Composer dependencies
FROM composer:2 as vendor

LABEL maintainer="eric.rosas@noirlab.edu"

COPY api/composer.json composer.json
COPY api/composer.lock composer.lock
RUN composer install --ignore-platform-reqs --no-interaction --prefer-dist

FROM us-central1-docker.pkg.dev/skyviewer/public-images/craft-base-image:$BASE_TAG

USER root

# Copy in custom code from the host machine.
WORKDIR /var/www/html
COPY --chown=www-data:www-data api/ ./

COPY --from=vendor --chown=www-data:www-data /app/vendor ./vendor
RUN mkdir /var/secrets && [ -d ./storage ] || mkdir storage

USER www-data

CMD ["supervisord"]
