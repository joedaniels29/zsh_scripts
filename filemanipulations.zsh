send_to_server(){
 local archive_name=$1.tar.gz
 rm -rf $archive_name;
 tar czvf $archive_name $1;
 scp $archive_name $2:$3
 ssh $2 "cd $3; tar xvzf $archive_name"
 ssh $2
}
into(){
 mkdir -p $1;
 cd $1;
}

lgrep(){
    local name=$1;
    shift;
    ls $* | grep $name
}
