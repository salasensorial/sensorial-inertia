# Usa a imagem oficial do PHP com Apache
FROM php:8.1-apache

# Instala dependências necessárias
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Ativa o mod_rewrite do Apache
RUN a2enmod rewrite

# Define o diretório de trabalho
WORKDIR /var/www/html

# Copia os arquivos do projeto para o contêiner
COPY . .

# Executa o Composer install
RUN composer install --no-dev --optimize-autoloader

# Define as permissões apropriadas
RUN chown -R www-data:www-data storage bootstrap/cache

# Expõe a porta 80
EXPOSE 80

# Comando para iniciar o Apache
CMD ["apache2-foreground"]