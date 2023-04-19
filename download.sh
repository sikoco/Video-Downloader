#!/bin/sh

IFS='/' read -r -a video <<< "$1"
echo ${video[7]}

if [ -z "$2" ]; then
    output_file="${video[7]}"
else
    output_file="$2"
fi

ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i "$1" -c copy "$output_file"
