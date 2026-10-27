# shimeji-hypr — Shimeji-ee on Hyprland

Native Wayland port of Shimeji-chan. Java/Swing can't do transparent, freely
positioned windows on Wayland, so this is a small Python client that draws the
mascot on a **wlr-layer-shell overlay** (GTK4 + gtk4-layer-shell). Hyprland
supports that protocol natively.

It reads the original `conf/actions.xml`, `conf/behaviors.xml` and
`img/<set>/*.png` unchanged, so other Shimeji-ee image sets with the same XML
structure work too (drop them in `img/`).

## Dependencies

| Distro | Packages |
|---|---|
| Arch | `pacman -S gtk4 gtk4-layer-shell python-gobject python-cairo` |
| Fedora | `dnf install gtk4 gtk4-layer-shell python3-gobject python3-cairo` |
| Debian/Ubuntu | `apt install libgtk-4-1 libgtk4-layer-shell0 gir1.2-gtk4layershell-1.0 python3-gi python3-gi-cairo` |
| NixOS | `gtk4`, `gtk4-layer-shell`, `python3Packages.pygobject3`, `python3Packages.pycairo` (set `LD_PRELOAD` to the layer-shell .so yourself) |

## Run

```sh
./shimeji-hypr                      # or ./install.sh, then `shimeji-hypr`
./shimeji-hypr --count 3 --scale 1.5
```

Autostart in `~/.config/hypr/hyprland.lua`:

```
exec-once = ~/.local/bin/shimeji-hypr
```

Options: `--count N`, `--scale F` (HiDPI), `--monitor N`, `--set NAME`,
`--layer top|overlay` (`top` hides under fullscreen windows, `overlay` stays
visible), `--data-dir PATH`.

## Controls

- Drag: pick her up (hang sprite); release to drop.
- Click her head: "Clicked" reaction. Click while asleep: wakes up.
- Right-click: Call another / Go to sleep / Walk / Dismiss / Quit.
- Only the sprite's pixels capture the mouse; everything else clicks through to your windows.
- Bars (waybar etc.) are respected: she roams the usable area only.

## What differs from the Windows version

- No tray icon, no "interactive windows", no multi-monitor roaming (one monitor per instance; run twice with `--monitor 0/1`). Wayland doesn't expose other clients' window geometry to apps.
- The XML engine is a faithful subset: Stay / Animate / Sequence / Look / Dragged actions, hotspots, behavior frequencies and NextBehaviorList. Environment-dependent features (climbing walls, sitting on windows, ChaseMouse) are not implemented; Shimeji-chan's config doesn't use them.
- The walk direction and 2px/tick speed follow the original `WalkWithDirection` formula.

## Troubleshooting

- `gtk4-layer-shell ... not installed`: you need the package that ships the **typelib** (`Gtk4LayerShell-1.0.typelib`).
- Wayland error / crash on start about linking order: set `LD_PRELOAD=/usr/lib/libgtk4-layer-shell.so` manually (the script tries this automatically).
- Pet not visible: check `hyprctl layers`, a namespace `shimeji` should be listed.
