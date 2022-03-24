wkhtmltoimage --enable-local-file-access --width 1080 --height 1920 --enable-local-file-access song.html song.png

wkhtmltoimage --enable-local-file-access --width 1080 --height 1920 --enable-local-file-access from.html from.png

convert from.png -transparent '#FF00FF' from2.png

#ffmpeg -i 'Vitas - Зима.flac' -an -vcodec copy art.bmp

ffmpeg -i art.bmp -vf "scale=-1:1920,crop=1080:1920" -vframes 1 artcropped.bmp
convert -brightness-contrast -50x-20 -blur 0x15 artcropped.bmp artfinal.bmp

# -stream_loop 1
ffmpeg -i 'Vitas - Зима.flac' -i song.png -i artfinal.bmp -i from2.png -filter_complex " [0:a] showwaves=s=1080x1920:mode=cline:s=1080x1920:colors=#404040@1:scale=sqrt:r=30,format=rgba [waveform]; \
[1:v] format=rgba [textimage]; \
[2:v] format=rgba [coverimage]; \
[coverimage][waveform] blend=all_mode=subtract [image]; \
[textimage][image] blend=all_mode=lighten:all_opacity=1,format=yuva422p10le[vid];
[vid][3:v]overlay" final.avi

rm from2.png
rm song.png
rm from.png
