wkhtmltoimage --enable-local-file-access --width 1080 --height 1920 --disable-smart-width song.html song.png

#ffmpeg -i 'Vitas - Зима.flac' -an -vcodec copy art.bmp

ffmpeg -i art.bmp -vf "scale=-1:1920,crop=1080:1920" -vframes 1 artcropped.bmp
convert -brightness-contrast -50x-20 -blur 0x15 artcropped.bmp artfinal.bmp

rm final.avi

ffmpeg -i 'Vitas - Зима.flac' -i song.png -i artfinal.bmp -filter_complex " \
[0:a] showwaves=s=1080x1920:mode=cline:s=1080x1920:colors=#303030@1:scale=sqrt:r=30,format=rgba [waveform]; \
[1:v] format=rgba [textimage]; \
[2:v] format=rgba [coverimage]; \
[coverimage][waveform] blend=all_mode=subtract,format=rgba [image]; \
[textimage][image] blend=all_mode=lighten:all_opacity=1,format=rgba" -vb 20M final.avi

rm artcropped.jpg