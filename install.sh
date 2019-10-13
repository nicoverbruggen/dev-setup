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

MYSQLPASS=$(openssl rand -base64 32)
echo "$MYSQLPASS"

# Make sure that NOBODY can access the server without a password
sudo mysql -e "UPDATE mysql.user set authentication_string=PASSWORD('$MYSQLPASS') where user='root'"
# Only allow local login
sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
# Ensure we can login locally
sudo mysql -e "UPDATE mysql.user SET plugin='mysql_native_password' WHERE User='root'"
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQLPASS'"
# Make our changes take effect
sudo mysql -e "FLUSH PRIVILEGES"

# Create a file on the desktop
touch "$HOME/Desktop/Passphrases.md"
echo "Your MySQL password: $MYSQLPASS" | tee "$HOME/Desktop/Passphrases.md"
echo "Your passphrases have been saved on your desktop. Store these in a safe location!"
