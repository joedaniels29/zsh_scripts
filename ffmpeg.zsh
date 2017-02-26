#!/usr/bin/env zsh

ffmpeg_reset_times(){
     ffmpeg -i $1 -write_xing 0 -c:v copy -c:a copy $2
}
ffmpeg_merge_all(){
    ffmpeg -f concat -safe 0 -i <(for f in ./*.mp3(n); do echo "file '$PWD/$f'"; done) -c copy output.mp3
}

ffmpeg_merge_and_resize(){
    local newName=${PWD:t};
    rm -rf output.mp3
    ffmpeg_merge_all;
    ffmpeg_reset_times output.mp3 ${newName}.mp3
    rm -rf output.mp3
    echo file named ${newName}.mp3
}
