file_size(){
    # wc -c $1 | awk '{print $1}'
    ruby -e "puts '%d' % (File.size(\"$1\"))"
}

file_size_kb(){
    # file_size $1 | sed 's/...$//'
    ruby -e "puts '%d' % (File.size(\"$1\") / 100)"
}
file_size_mb(){
    ruby -e "puts '%d' % (File.size(\"$1\") / 100000)"
}
