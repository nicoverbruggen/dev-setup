# How to set up a virtual machine with Linux for development purposes

    git clone git@github.com:nicoverbruggen/dev-setup.git
    cd dev-setup
    
Make the script you want executable:    
    
    chmod +x ./name-of-script.sh
    
Install PHP 7.4, node 12.x, nginx, MySQL 5.7, etc. by running:

    ./name-of-script.sh
    
Your MySQL installation's root account is automatically protected with an auto-generated password. It is echoed in the terminal, but also saved on your desktop.