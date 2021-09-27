#!/bin/sh

usage(){
	echo "Usage: ./mobiledemo <input_file>"
	echo "The input file can be of any format supported by ffmpeg"
	echo "An overlayed.mp4 file will be generated."
}
for i in "$@"
do
case $i in
    -h|--help)
		usage
		exit 0
    ;;
    *)
            # unknown option
    ;;
esac
done

if (( $# != 1 )); then
    echo "Illegal number of parameters"
	usage
	exit 1
fi

scaled=$(mktemp --suff=.mp4)
scaled_padded=$(mktemp --suff=.mp4)
maquette="maquette.png"

# Scale input video to size
ffmpeg -y -i "$1" \
	-vf scale=-2:2706 \
	-vcodec libx264  \
	-r 15 \
	-preset ultrafast \
	"$scaled"

# Add padding and center
ffmpeg -y -i "$scaled" \
	-vf "pad=1588:3512:118:389" \
	-vcodec libx264  \
	-preset ultrafast \
	"$scaled_padded"

# Overlay the phone frame on top of the video, they should have the same size
ffmpeg -y -i "$scaled_padded" -i "$maquette" \
	-filter_complex "[0:v][1:v] overlay=0:0:enable='1'" \
	-c:a copy \
	-vcodec libx264  \
	-preset ultrafast \
	overlayed.mp4

rm -rf "$scaled"
rm -rf "$scaled_padded"
