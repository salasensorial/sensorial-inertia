# Usa a imagem oficial do PHP como base
FROM php:8.1-fpm

# Instala as dependências necessárias
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    && docker-php-ext-install zip
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Define o diretório de trabalho
WORKDIR /var/www

# Copia os arquivos do projeto para o contêiner
COPY . .

# Executa o Composer install
RUN composer install