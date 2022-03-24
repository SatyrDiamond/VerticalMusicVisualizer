wkhtmltoimage --enable-local-file-access --width 1080 --height 1920 --enable-local-file-access song.html song.png

wkhtmltoimage --enable-local-file-access --width 1080 --height 1920 --enable-local-file-access from.html from.png

convert from.png -transparent '#FF00FF' from2.png

# -stream_loop 1
ffmpeg  -y -i "Module2n.wav" -i song.png -i from2.png -filter_complex " \
[0:a] showwaves=s=1080x1920:mode=cline:s=1080x1920:colors=#383838@0.9:scale=sqrt:r=30,format=rgba [bg]; \
[1:v] format=rgba [fg]; \
[bg][fg] blend=all_mode=lighten:all_opacity=1,format=yuva422p10le[vid]; [vid][2:v]overlay" -vb 20M final.avi

