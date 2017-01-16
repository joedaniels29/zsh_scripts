isw(){
    local pee=$( pwd );
    echo -n && sleep 3 && echo "import ${pee:t}" && cat | swift -deprecated-integrated-repl   -I $pee
}

isw-print(){
    local pee=$( pwd );
    { echo -n && sleep 3 && echo "import ${pee:t}\n print(\"hi\");\n :print_module ${pee:t}\n" ; cat } | swift -deprecated-integrated-repl   -I $pee
}
