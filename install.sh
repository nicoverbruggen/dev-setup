#!/bin/bash

# Add PHP PPA
sudo add-apt-repository -y ppa:ondrej/php

# Add NodeJS PPA
VERSION=node_10.x
DISTRO=bionic
echo "deb https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee /etc/apt/sources.list.d/nodesource.list
echo "deb-src https://deb.nodesource.com/$VERSION $DISTRO main" | sudo tee -a /etc/apt/sources.list.d/nodesource.list
curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -

# Install packages
sudo apt-get update
sudo apt-get install -y build-essential curl file git composer php7.3 php7.3-imagick php7.3-xml php7.3-mbstring php7.3-zip php7.3-mysql php7.3-curl php-fpm git nginx mysql-server nodejs jq xsel libnss3-tools

# Install Valet
composer global require cpriego/valet-linux
echo "PATH=\"$HOME/.config/composer/vendor/bin:$PATH\"" | tee ~/.profile
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
valet install

# Create phpinfo folder & link
mkdir "$HOME/Code"
mkdir "$HOME/Code/phpinfo"
touch "$HOME/Code/phpinfo/index.php"
echo "<?php phpinfo() ?>" | tee "$HOME/Code/phpinfo/index.php"
cd "$HOME/Code/phpinfo"
valet link phpinfo

# Cleanup
sudo apt autoremove
