wkhtmltoimage --enable-local-file-access --width 1080 --height 1920 --disable-smart-width song.html song.png

rm final.avi

ffmpeg -i 'Module2.s3m' -i song.png -filter_complex " \
[0:a] showwaves=s=1080x1920:mode=cline:s=1080x1920:colors=#383838@0.9:scale=sqrt:r=30,format=rgba [waveform]; \
[1:v] format=rgba [textimage]; \
[waveform][textimage] blend=all_mode=lighten:all_opacity=1,format=yuva422p10le" -vb 20M final.avi
