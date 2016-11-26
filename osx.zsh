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
swiftBuild(){
    if [[ -z ./Package.swift ]]; then
        echo 'wheres the Package.swift?'
    fi
    rm -rf Packages;
    swift build;
}
