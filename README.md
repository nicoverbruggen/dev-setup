# How to set up a virtual machine w/ Linux Mint (tina) for development purposes

    git clone git@github.com:nicoverbruggen/mint-tina-dev-setup.git
    cd mint-tina-dev-setup
    
Make the script executable:    
    
    chmod +x ./install.sh
    
Install PHP 7.3, node 10.x, nginx, MySQL 5.7, etc. by running:

    ./install.sh
    
Your MySQL installation's root account is automatically protected with an auto-generated password. It is echoed in the terminal, but also saved on your desktop.
