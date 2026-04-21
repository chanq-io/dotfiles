# radeontop Cheatsheet

Monitor AMD GPU utilization in the terminal. Shows real-time usage of GPU components via hardware performance counters.

## Basic Usage

```bash
radeontop                          # Start monitoring (default GPU)
sudo radeontop                     # May need root for some metrics
radeontop -b 0                     # Monitor specific PCI bus
```

## Key Flags

| Flag                  | Description                                          |
|-----------------------|------------------------------------------------------|
| `-b BUS`              | Select GPU by PCI bus number (hex, e.g., `0a`)      |
| `-d FILE`/`--dump`   | Dump stats to file (machine-readable)                |
| `-c`/`--color`       | Enable color output                                  |
| `-e`/`--no-color`    | Disable color                                        |
| `-l LIMIT`           | Refresh rate limit in ms (default: ~1000)            |
| `-t`/`--ticks`       | Number of ticks per sampling period                  |
| `-i SEC`              | Dump interval in seconds (with `-d`)                |

## Metrics Displayed

| Metric                         | Description                                              |
|--------------------------------|----------------------------------------------------------|
| **Graphics pipe**              | GPU shader/compute utilization                           |
| **Event Engine**               | Command processor activity                               |
| **Vertex Grouper + Tesselator**| Vertex processing stage utilization                      |
| **Texture Addresser**          | Texture coordinate processing                            |
| **Texture Cache**              | Texture memory cache activity                            |
| **Shader Interpolator**        | Pixel shader input interpolation                         |
| **Shader Export**              | Shader output write activity                             |
| **Sequencer Instruction Cache**| Shader instruction cache                                 |
| **Scan Converter**             | Rasterizer utilization                                   |
| **Primitive Assembly**         | Geometry primitive processing                            |
| **Depth Block**                | Z-buffer / depth test activity                           |
| **Color Block**                | Color/pixel output activity                              |
| **VRAM usage**                 | Video memory used / total                                |
| **GTT usage**                  | Graphics Translation Table (system RAM mapped) used      |
| **Memory Clock**               | Current VRAM clock speed                                 |
| **Shader Clock**               | Current GPU core clock speed                             |

## TUI Display

The TUI shows horizontal bars for each GPU pipeline stage:

```
Graphics pipe  85.00%  |################   |
Event Engine   42.00%  |########           |
...
VRAM 1234/8192 MB  15.07%
GTT   128/4096 MB   3.13%
```

Each bar fills proportionally to utilization percentage.

## Dump Mode

```bash
radeontop -d /tmp/gpu.log                    # Dump to file (default interval)
radeontop -d /tmp/gpu.log -i 2               # Dump every 2 seconds
radeontop -d - -l 500                        # Dump to stdout, 500ms refresh
```

Dump format is one line per sample with key=value pairs:

```
1700000000.123, gpu 85.00, ee 42.00, vgt 30.00, ta 55.00, ...
```

Useful for logging GPU usage over time or feeding to graphing tools.

## PCI Bus Selection

```bash
# List AMD GPUs
lspci | grep -i amd | grep -i vga

# Example output: 0a:00.0 VGA compatible controller: AMD...
radeontop -b 0a                    # Use bus number from lspci
```

## Examples

```bash
# Basic monitoring with color
radeontop -c

# Fast refresh rate (500ms)
radeontop -l 500

# Log GPU usage to file for 10 minutes
timeout 600 radeontop -d /tmp/gpu_log.txt -i 1

# Monitor second GPU
radeontop -b 43

# Dump to stdout for piping
radeontop -d - | tee gpu_stats.log
```

## Notes

- Works with AMD Radeon GPUs using the AMDGPU or radeon kernel drivers.
- Reads from `/sys/kernel/debug/dri/` (may need root if debugfs is restricted).
- VRAM and GTT usage require appropriate kernel driver support.
- For NVIDIA GPUs, use `nvidia-smi` instead. For Intel, use `intel_gpu_top`.
