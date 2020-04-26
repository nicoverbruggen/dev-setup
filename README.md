# How to set up a virtual machine with Linux for development purposes

    git clone git@github.com:nicoverbruggen/dev-setup.git
    cd dev-setup
    
Make the script you want executable:    
    
    chmod +x ./name-of-script.sh
    
Install PHP 7.4, node 12.x, nginx, MySQL 5.7, etc. by running:

    ./name-of-script.sh
    
Your MySQL installation's root account is automatically protected with an auto-generated password. It is echoed in the terminal, but also saved on your desktop.

Upgrading to PHP 7.4:

    sudo apt-get remove -y php7.3 php7.3-imagick php7.3-xml php7.3-mbstring php7.3-zip php7.3-mysql php7.3-curl php7.3-fpm
    sudo apt-get install -y php7.4 php7.4-imagick php7.4-xml php7.4-mbstring php7.4-zip php7.4-mysql php7.4-curl php7.4-fpm
    valet install
