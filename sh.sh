wkhtmltoimage --width 576 --height 1024 --disable-smart-width song.html song.png

rm final.mp4

ffmpeg -i TonyThai.flac -i song.png -filter_complex " \
[0:a] showwaves=s=576x1024:mode=cline:s=576x1024:colors=#222222@0.9:scale=sqrt:r=30,format=rgba [bg]; \
[1:v] format=rgba [fg]; \
[bg][fg] blend=all_mode=lighten:all_opacity=1,format=yuva422p10le" final.mp4