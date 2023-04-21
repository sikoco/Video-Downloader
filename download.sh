#!/bin/sh

usage() {
  cat <<EOF
Usage: $0 [-h] input_file [output_file]

Downloads and converts a video file to MP4 format using FFmpeg.

Positional arguments:
  input_file      Input video URL.
  output_file     (Optional) Output file name. If not provided, defaults to the current date and time in the format YYYY_MM_DD-hh_mm_ss.mp4.

Optional arguments:
  -h, --help      Show this help message and exit.

EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    -h|--help) usage; exit 0;;
    *) break;;
  esac
  shift
done

if [ -z "$1" ]; then
  echo "Input file argument missing. See usage below." >&2
  usage >&2
  exit 1
fi

IFS='/' read -r -a video <<< "$1"
echo ${video[7]}

if [ -z "$2" ]; then
  output_file=$(date +'%Y_%m_%d-%H_%M_%S').mp4
else
  output_file="$2"
fi

ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i "$1" -c copy "$output_file"


