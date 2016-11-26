



firewall_functions(){
    sudo ufw status verbose
}

firewall_configure_defaults(){
    sudo ufw reset
    sudo ufw allow 51790/tcp
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
}
