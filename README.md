# How to set up a virtual machine w/ Linux Mint (tina) for development purposes

    git clone git@github.com:nicoverbruggen/mint-tina-dev-setup.git
    cd mint-tina-dev-setup
    
Make the script executable:    
    
    chmod +x ./install.sh
    
Install PHP 7.3, node 10.x, nginx, MySQL 5.7, etc. by running:

    ./install.sh
    
Your MySQL installation's root account is automatically protected with an auto-generated password. It is echoed in the terminal, but also saved on your desktop.

Upgrading to PHP 7.4:

    sudo apt-get remove -y php7.3 php7.3-imagick php7.3-xml php7.3-mbstring php7.3-zip php7.3-mysql php7.3-curl php7.3-fpm
    sudo apt-get install -y php7.4 php7.4-imagick php7.4-xml php7.4-mbstring php7.4-zip php7.4-mysql php7.4-curl php7.4-fpm
    valet install
