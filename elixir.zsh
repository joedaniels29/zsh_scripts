ember_phoenix_deploy(){
    ssh home "echo ohai"
}


phoenix_deploy(){
    if [[ ! -d ~/Projects/Mine/$1/ ]]; then
    echo "error! no $1"
    return
    fi
    local projectLocation=~/Projects/Mine/$1/;
    cd $projectLocation;

    cd priv/static
    git_be_gone;
    git pull origin;
    1;  

    cd $projectLocation;

    PORT=8888 MIX_ENV=prod mix do deps.get, compile, release --verbose
    PORT=8888 ./rel/$1/bin/$1 restart
    # PORT=8888 ./rel/$1/bin/$1 start



}
