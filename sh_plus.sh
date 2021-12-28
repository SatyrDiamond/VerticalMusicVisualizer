wkhtmltoimage --width 576 --height 1024 --enable-local-file-access song.html song.png

wkhtmltoimage --width 576 --height 1024 --enable-local-file-access from.html from.png

convert from.png -transparent '#FF00FF' from2.png

ffmpeg -y -i test.wav -i song.png -i from2.png -filter_complex " \
[0:a] showwaves=s=576x1024:mode=cline:s=576x1024:colors=#333333@0.9:scale=sqrt:r=30,format=rgba [bg]; \
[1:v] format=rgba [fg]; \
[bg][fg] blend=all_mode=lighten:all_opacity=1,format=yuva422p10le[vid]; [vid][2:v]overlay" -vb 20M final.avi
