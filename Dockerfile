FROM php:8.1-apache-bullseye

ENV DEBIAN_FRONTEND noninteractive
ENV JEMALLOC_VERSION=5.3.0
ENV VIPS_VERSION=8.13.3
WORKDIR /usr/local/src

RUN export MAKEFLAGS="-j $(nproc)" \
 && apt-get update && apt-get install --no-install-recommends -y  \
    build-essential \
    libgirepository1.0-dev\
    meson \
    pkg-config \
    libglib2.0-dev \
    libexif-dev \
    libexpat1-dev \
    libffi-dev \
    libpoppler-glib-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libimagequant-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    librsvg2-dev \
    libxml2-dev \
    libzip-dev \
    unzip \
    zip \
 && curl -sLO https://github.com/jemalloc/jemalloc/releases/download/${JEMALLOC_VERSION}/jemalloc-${JEMALLOC_VERSION}.tar.bz2 \
 && tar xf jemalloc-${JEMALLOC_VERSION}.tar.bz2 && cd jemalloc-${JEMALLOC_VERSION} \
 && ./configure --disable-fill --disable-stats \
 && make && make install_lib_shared \
 && cd .. && rm -R jemalloc-${JEMALLOC_VERSION} && rm jemalloc-${JEMALLOC_VERSION}.tar.bz2 \
 && curl -sLO https://github.com/libvips/libvips/releases/download/v${VIPS_VERSION}/vips-${VIPS_VERSION}.tar.gz \
 && tar xf vips-${VIPS_VERSION}.tar.gz && cd vips-${VIPS_VERSION} \
 && meson build --prefix /usr/local --libdir lib \
 && cd build && meson compile && meson install && ldconfig \
 && cd ../.. && rm -R vips-${VIPS_VERSION} && rm vips-${VIPS_VERSION}.tar.gz\
 && docker-php-ext-configure zip \
 && docker-php-ext-install -j$(nproc) \
    ffi \
    opcache \
    zip \
 && echo 'ffi.enable=1' >> /usr/local/etc/php/conf.d/docker-php-ext-ffi.ini

ENV LD_PRELOAD=/usr/local/lib/libjemalloc.so.2
ENV MALLOC_CONF="dirty_decay_ms:500"
WORKDIR /var/www
COPY ./ .
