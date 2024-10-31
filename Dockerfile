# Usa a imagem oficial do PHP como base
FROM php:8.1-fpm

# Instala as dependências
RUN apt-get update && apt-get install -y libzip-dev && docker-php-ext-install zip

# Define o diretório de trabalho
WORKDIR /var/www

# Copia os arquivos do projeto para o contêiner
COPY . .

# Instala o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Instala as dependências do Laravel
RUN composer install

# Expõe a porta 9000
EXPOSE 9000

CMD ["php-fpm"]
