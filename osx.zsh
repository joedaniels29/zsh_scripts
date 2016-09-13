osx_update_list(){
    softwareupdate -l;
}

osx_update_install_all(){
    sudo softwareupdate -iva;
    sudo reboot;
}

osx_update_install_reccomended(){
    sudo softwareupdate -irv;
    sudo reboot;
}
