#personal wrapper for yt-dlp

#argc check
if [ $# -lt 2 ] || [ $1 = -h ] || [ $1 = help ] || [ $1
= --help ];
then
        echo "usage: download <mp3/mp4> <URL> [path]"
        exit
fi

#define format
if [ $1 = mp3 ]; then
        arg="-f ba -x --audio-format mp3"
elif [ $2 = mp4 ]; then
        arg="-f mp4"
else
        echo unknown format
        exit
fi

#if path is passed, use it
if [ $# -eq 3 ]; then
        path="$3"
else
        path="/storage/emulated/0/term_download_$1"
fi

#ugh annoying
#yt-dlp -s $2
#
#echo continue? [Yn]
#read _
#
#if [ read = n ] || [ read = N ]; then
#       exit
#fi

#actual download
yt-dlp -o "${path}/temp/%(title)s.%(ext)s" ${arg} $2


cd "${path}/temp"
for i in *; do
        if [ $1 = mp4 ]; then
                newname="${i%.*}.mp4"
                ffmpeg -i "$i" "${newname}"
                mv "${newname}" "../${newname}"
        else
                mv "$i" "../$i"
        fi
done

cd ..
rm -rf temp
cd

echo DONE!!!
