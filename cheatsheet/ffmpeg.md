# ffmpeg

Swiss-army knife for audio/video processing, conversion, and streaming.

---

## Basic Syntax

```bash
ffmpeg -i input.mp4 [options] output.mkv
ffmpeg -i input1.mp4 -i input2.mp3 [options] output.mp4
```

## Common Flags

| Flag | Action |
|------|--------|
| `-i FILE` | Input file |
| `-c:v CODEC` | Video codec (`libx264`, `libx265`, `libvpx-vp9`, `copy`) |
| `-c:a CODEC` | Audio codec (`aac`, `libopus`, `libmp3lame`, `copy`) |
| `-c copy` | Stream copy (no re-encode, fast) |
| `-b:v RATE` | Video bitrate (`2M`, `5000k`) |
| `-b:a RATE` | Audio bitrate (`128k`, `320k`) |
| `-r FPS` | Frame rate |
| `-s WxH` | Resolution (`1920x1080`) |
| `-ss TIME` | Seek to (start time) |
| `-t DURATION` | Duration |
| `-to TIME` | End time |
| `-vf FILTER` | Video filter chain |
| `-af FILTER` | Audio filter chain |
| `-map STREAM` | Select specific streams |
| `-f FORMAT` | Force format |
| `-y` | Overwrite without asking |
| `-n` | Never overwrite |
| `-an` | No audio |
| `-vn` | No video |
| `-sn` | No subtitles |

## Common Codecs

| Type | Codec | Flag |
|------|-------|------|
| H.264 | libx264 | `-c:v libx264` |
| H.265/HEVC | libx265 | `-c:v libx265` |
| VP9 | libvpx-vp9 | `-c:v libvpx-vp9` |
| AV1 | libaom-av1 / libsvtav1 | `-c:v libsvtav1` |
| AAC | aac / libfdk_aac | `-c:a aac` |
| Opus | libopus | `-c:a libopus` |
| MP3 | libmp3lame | `-c:a libmp3lame` |

## CRF Quality (H.264/H.265)

Lower = better quality, bigger file. H.264 default: 23, H.265 default: 28.

```bash
ffmpeg -i in.mp4 -c:v libx264 -crf 18 -preset slow out.mp4
ffmpeg -i in.mp4 -c:v libx265 -crf 24 -preset medium out.mp4
```

**Presets:** `ultrafast`, `superfast`, `veryfast`, `faster`, `fast`, `medium`, `slow`, `slower`, `veryslow`

## Common Recipes

```bash
# Convert format (re-encode)
ffmpeg -i in.mov -c:v libx264 -c:a aac out.mp4

# Fast convert (stream copy, no re-encode)
ffmpeg -i in.mkv -c copy out.mp4

# Extract audio
ffmpeg -i video.mp4 -vn -c:a copy audio.aac
ffmpeg -i video.mp4 -vn -c:a libmp3lame -b:a 320k audio.mp3

# Trim / cut
ffmpeg -i in.mp4 -ss 00:01:30 -t 00:00:30 -c copy clip.mp4
ffmpeg -i in.mp4 -ss 00:01:30 -to 00:02:00 -c copy clip.mp4

# Resize / scale
ffmpeg -i in.mp4 -vf "scale=1280:720" out.mp4
ffmpeg -i in.mp4 -vf "scale=-1:720" out.mp4   # auto width

# Change framerate
ffmpeg -i in.mp4 -r 30 out.mp4

# GIF from video
ffmpeg -i in.mp4 -ss 5 -t 3 -vf "fps=10,scale=320:-1" out.gif

# Video to images
ffmpeg -i in.mp4 -vf "fps=1" frame_%04d.png

# Images to video
ffmpeg -framerate 24 -i frame_%04d.png -c:v libx264 out.mp4

# Add subtitles (burn in)
ffmpeg -i in.mp4 -vf "subtitles=subs.srt" out.mp4

# Concatenate files (via file list)
# concat.txt: file 'part1.mp4'\nfile 'part2.mp4'
ffmpeg -f concat -safe 0 -i concat.txt -c copy out.mp4

# Add audio to video
ffmpeg -i video.mp4 -i audio.mp3 -c copy -map 0:v -map 1:a out.mp4

# Compress video
ffmpeg -i in.mp4 -c:v libx264 -crf 28 -preset fast -c:a aac -b:a 128k out.mp4

# Strip audio
ffmpeg -i in.mp4 -an -c:v copy out.mp4

# Resample audio
ffmpeg -i in.wav -ar 16000 out.wav

# Screen recording (Wayland via PipeWire)
ffmpeg -f pipewire -i default -c:v libx264 -crf 20 screen.mp4
```

## Video Filters (`-vf`)

```bash
scale=1280:720               # resize
scale=-1:720                 # auto-width maintain aspect
crop=640:480:100:50          # crop WxH+X+Y
fps=30                       # change framerate
transpose=1                  # rotate 90° CW
hflip / vflip                # mirror
drawtext=text='Hello':fontsize=24:x=10:y=10
overlay=10:10                # overlay second input
```

## Audio Filters (`-af`)

```bash
volume=2.0                   # double volume
volume=0.5                   # halve volume
atempo=1.5                   # speed up audio
loudnorm                     # normalize loudness (EBU R128)
highpass=f=200               # high-pass filter
lowpass=f=3000               # low-pass filter
```

## Probe / Info

```bash
ffprobe input.mp4                    # show file info
ffprobe -show_streams input.mp4      # detailed stream info
ffprobe -show_format input.mp4       # format info
```
