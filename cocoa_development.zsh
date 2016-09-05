xcreset(){
    rm -rf ~/Library/Developer/CoreSimulator/
    rm -rf ~/Library/Developer/Xcode/DerivedData
    rm -rf "$(getconf DARWIN_USER_CACHE_DIR)/org.llvm.clang/ModuleCache"
}
xc_is_ok(){
    if (( $# == 1 ));
    then xattr -d com.apple.quarantine $1;
    else xattr -d com.apple.quarantine com.apple.quarantine "/Applications/Xcode.app";
    fi

}
