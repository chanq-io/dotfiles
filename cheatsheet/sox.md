# sox

Audio processing command-line tool. Record, play, convert, and apply effects.

---

## Basic Syntax

```bash
sox input.wav output.wav [effect ...]
sox input1.wav input2.wav output.wav   # concatenate
soxi file.wav                           # show file info
rec output.wav                          # record from mic
play file.wav                           # play audio
```

## Format Flags

| Flag | Action |
|------|--------|
| `-r RATE` | Sample rate (e.g., 44100, 16000) |
| `-c N` | Channels (1=mono, 2=stereo) |
| `-b BITS` | Bit depth (16, 24, 32) |
| `-e ENCODING` | Encoding (`signed`, `unsigned`, `float`) |
| `-t FORMAT` | File type (`wav`, `raw`, `flac`, `mp3`) |
| `-v FACTOR` | Volume adjustment |
| `-n` | Null file (use as output for stats, or input for synth) |

## Common Effects

| Effect | Action |
|--------|--------|
| `rate RATE` | Resample to RATE Hz |
| `channels N` | Convert to N channels |
| `trim START =LEN` | Cut from START for LEN |
| `trim START END` | Cut from START to END |
| `fade TYPE IN 0 OUT` | Fade in/out (`l`=linear, `t`=triangle, `q`=quarter) |
| `norm` | Normalize to 0dB |
| `norm -3` | Normalize to -3dB |
| `gain -n -3` | Normalize then apply -3dB gain |
| `vol FACTOR` | Adjust volume |
| `speed FACTOR` | Change speed (affects pitch) |
| `tempo FACTOR` | Change speed (preserve pitch) |
| `pitch CENTS` | Shift pitch in cents |
| `reverb` | Add reverb |
| `chorus` | Add chorus effect |
| `silence 1 0.1 1%` | Remove leading silence |
| `remix 1` | Downmix to mono (take channel 1) |
| `remix 1,2` | Keep both channels as-is |
| `pad START END` | Add silence at start/end |
| `repeat N` | Repeat N times |
| `reverse` | Reverse audio |
| `bass +5` | Boost bass |
| `treble +5` | Boost treble |

## Common Recipes

```bash
# Convert format
sox in.wav out.flac

# Resample to 16kHz mono
sox in.wav -r 16000 -c 1 out.wav

# Trim first 30 seconds
sox in.wav out.wav trim 0 30

# Trim from 1:00 to 2:00
sox in.wav out.wav trim 60 60

# Normalize audio
sox in.wav out.wav norm

# Fade in 2s, fade out 3s
sox in.wav out.wav fade t 2 0 3

# Speed up 1.5x (preserving pitch)
sox in.wav out.wav tempo 1.5

# Remove silence from start and end
sox in.wav out.wav silence 1 0.1 1% reverse silence 1 0.1 1% reverse

# Concatenate files
sox file1.wav file2.wav file3.wav combined.wav

# Mix/overlay two files
sox -m track1.wav track2.wav mixed.wav

# Generate sine wave (5 seconds, 440Hz)
sox -n tone.wav synth 5 sine 440

# Get audio stats
sox file.wav -n stat
sox file.wav -n stats

# Show file info
soxi file.wav
soxi -d file.wav    # duration only
soxi -r file.wav    # sample rate only
```
