{
  # zram-backed compressed swap. Compresses cold anonymous pages in RAM
  # (zstd) instead of paging out to the NVMe swap partition. Same idea as
  # macOS memory compression: large in-memory working sets (rust-analyzer,
  # browser tabs) effectively shrink instead of triggering OOM.
  # Disk swap (/dev/nvme0n1p3) stays as a final fallback at lower priority.
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
  };
}
