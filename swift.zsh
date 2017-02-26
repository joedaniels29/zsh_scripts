#!/usr/bin/env zsh

isw(){
    local pee=$( pwd );
    echo -n && sleep 3 && echo "import ${pee:t}" && cat | swift -deprecated-integrated-repl   -I $pee
}

isw-print(){
    local pee=$( pwd );
    { echo -n && sleep 3 && echo "import ${pee:t}\n print(\"hi\");\n :print_module ${pee:t}\n" ; cat } | swift -deprecated-integrated-repl   -I $pee
}
swift-protobuf-generate(){
    local pee=$( pwd );
    { echo -n && sleep 3 && echo "import ${pee:t}\n print(\"hi\");\n :print_module ${pee:t}\n" ; cat } | swift -deprecated-integrated-repl   -I $pee
}


swift_protobuf_generate(){
    local ppath=$1;
    local returnTo=$(pwd);
    cd $ppath;
    local files=( ./*.pb.swift(N) );
    (($#files != 0))  && rm -rf  $files;
    protoc --swift_out=. ./*
    cd $returnTo;
}

# Process to generate swift Interface for ruby
_ruby-interfaceI(){

    gcc -CC -P   -I /usr/include -I/usr/local/Cellar/ruby/2.4.0/include/ruby-2.4.0/x86_64-darwin16/ -I/usr/local/Cellar/ruby/2.4.0/include/ruby-2.4.0/ -E  ruby.h >! ~/Projects/Mine/ruby/ruby/ruby_pre.h
    echo :print_module Ruby | swift -deprecated-integrated-repl   -I /Users/joe/Projects/Mine/ruby/  > RubyInterface.interface.swift
}
