#!/bin/bash

# Add PHP PPA
sudo add-apt-repository -y ppa:ondrej/php

# Install NodeJS 12.x
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install packages
sudo apt-get update
sudo apt-get install -y build-essential curl file git composer php7.4 php7.4-imagick php7.4-xml php7.4-mbstring php7.4-zip php7.4-mysql php7.4-curl php-fpm git nginx mysql-server nodejs jq xsel libnss3-tools

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
