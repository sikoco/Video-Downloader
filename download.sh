#!/bin/sh

IFS='/' read -r -a video <<< "$1"
echo ${video[7]}

if [ "${video[7]}" = "" ]; then
    output_file="output.mp4" # Set a default output file name
else
    output_file="${video[7]}"
fi

ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i "$1" -c copy "$output_file"

