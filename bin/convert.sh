webmToMp4() {
	ffmpeg -i "$1".webm -qscale 0 "$1".mp4 -loglevel error
}

mp4ToMp3() {
	ffmpeg -i "$1".mp4 "$1".mp3 -loglevel error
}

# pandoc: markdown+xalatex -> pdf/html
