# qpwgraph

PipeWire patchbay — visual tool for routing audio/MIDI between applications.

---

## Usage

```bash
qpwgraph              # launch GUI
qpwgraph -a           # start activated (auto-connect)
qpwgraph FILE.qpwgraph  # load a saved patchbay
```

## GUI Operations

| Action | How |
|--------|-----|
| Connect ports | Drag from output port to input port |
| Disconnect | Right-click connection line → Disconnect |
| Move nodes | Click and drag |
| Zoom | Scroll wheel |
| Pan | Middle-click drag |
| Select all | `Ctrl+A` |
| Refresh | `F5` |

## Patchbay Management

| Action | How |
|--------|-----|
| Save patchbay | `Ctrl+S` or File → Save |
| Load patchbay | `Ctrl+O` or File → Open |
| Activate patchbay | Toggle "Patchbay" button |

When activated, qpwgraph auto-maintains saved connections as apps start/stop.

## Tips

- Nodes are color-coded: ALSA (orange), PipeWire (blue), MIDI (green)
- Filter nodes with the search bar at top
- Right-click a node to rename or disconnect all
