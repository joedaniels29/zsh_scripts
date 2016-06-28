xcreset(){
    rm -rf ~/Library/Developer/CoreSimulator/
    rm -rf ~/Library/Developer/Xcode/DerivedData
    rm -rf "$(getconf DARWIN_USER_CACHE_DIR)/org.llvm.clang/ModuleCache"
}
