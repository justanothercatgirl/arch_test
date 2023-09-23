#personal wrapper for yt-dlp
version=2.3                                                                                                   
echo youtube downloader wrapper, version ${version}
 
#argc check
if [ $# -lt 2  ] || [ $1 = -h  ] || [ $1 = help ] || [ $1 = --help  ];
then
        echo "usage: bash download.sh <mp3/mp4> <URL> [path]"
        exit
fi
 
#define format
if [ $1 = mp3 ]; then
        arg="-f ba -x --audio-format mp3"
elif [ $1 = mp4 ]; then
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
 
#actual download
yt-dlp -o "${path}/temp/%(title)s.%(ext)s" --progress ${arg} "$2"
 
#change metdata
restore=`pwd`
cd "${path}/temp"
for i in *; do
        eyeD3 --quiet --release-date `date +%Y-%m-%dT%H:%M:%S` "$i"
        mv "$i" "${path}"
done
cd ${restore}
                                                        #remove temporary directory
rm -r "${path}/temp"
 
echo Version ${version}: done!
