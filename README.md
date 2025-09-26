# MATLAB Solar–Earth–Moon Visualizer

**TL;DR**: A compact MATLAB demo that renders textured spheres for the Sun, Earth, and Moon, then animates Earth and Moon orbits using simple angular velocities. It is designed as a reproducible, teaching‑friendly visualization (not a physically accurate simulator).

![teaser](docs/outputs/teaser.png)

---

## Features

* 🌍 **Textured bodies**: Sun (`sun.jpg`), Earth (`earth.jpg`), Moon (`moon.jpg`) mapped onto spheres.
* ☀️ **Background**: starfield texture (`space.jpg`) tiled as a 3‑plane skybox.
* 🌀 **Animation**: Earth orbits the Sun; Moon orbits Earth. Rotation of Earth/Moon meshes is updated each frame.
* ⚙️ **Minimal code**: single script with a helper `getxyz` function; easy to read and modify.

---

## Repository Layout (Suggested)

```
Solar-System-Visualizer/
├─ src/
│  └─ solar_demo.m              # main script (your current file)
├─ resources/
│  ├─ space.jpg
│  ├─ sun.jpg
│  ├─ earth.jpg
│  └─ moon.jpg
├─ docs/
│  └─ outputs/
│     └─ teaser.png             # captured frame for README
├─ README.md
└─ LICENSE
```

> You can keep file names as you like; make sure the image paths in the script match `resources/` or adjust accordingly.

---

## Requirements

* MATLAB **R2021b+** (R2022b or newer recommended).
* No toolboxes required; uses base functions (`imread`, `sphere`, `surf`, `meshgrid`, `imshow`, etc.).

---

## Quick Start

```matlab
% From repo root
addpath('src');
addpath('resources');
solar_demo;      % run the animation, press close button to stop
```

If images are placed under `resources/`, update the paths in the script accordingly (e.g., `imread('resources/earth.jpg')`).

---

## Parameters (inside the script)

| Name                      | Meaning                                              | Default                 |
| ------------------------- | ---------------------------------------------------- | ----------------------- |
| `Rsun`, `Rearth`, `Rmoon` | Radii of bodies (visual units)                       | 30, 6, 1.5              |
| `R1`, `R2`                | Orbit radii (Earth–Sun, Moon–Earth)                  | `2*Rsun`, `1.5*Rearth`  |
| `V1`, `V2`                | Angular speeds (Earth around Sun, Moon around Earth) | `2π/365.25`, `2π/27.32` |
| `datpart`                 | Frames per day (temporal resolution)                 | 24                      |

> Note: values are chosen for a visually pleasing demo, not for astronomical scale accuracy.

---

## How It Works (High Level)

1. **Geometry**: `sphere(50)` generates a unit sphere mesh; `getxyz` scales (`R`) and rotates (`theta`) the mesh, then translates it to `center`.
2. **Background**: three large quads form a simple skybox; `space.jpg` is texture‑mapped to them.
3. **Animation loop**: per frame `t`, compute angles `dt1 = t*V1/datpart`, `dt2 = t*V2/datpart`, update centers `Pearth`, `Pmoon`, and rotate meshes before updating `XData/YData/ZData`.

---

## Known Limitations

* **Not to scale**: distances/sizes are artistic, not astronomical.
* **Infinite loop**: the `while 1` loop runs until the user closes the figure; consider adding a keypress/timeout for demos.
* **Z‑order/background**: the 3‑plane skybox is a lightweight approximation; a cube‑map would look cleaner.

---

## Tips & Extensions

* Save a frame for documentation:

  ```matlab
  frame = getframe(gcf); imwrite(frame.cdata, 'docs/outputs/teaser.png');
  ```
* Add a **keypress handler** to stop animation (e.g., `set(gcf,'KeyPressFcn',@(~,e) assignin('base','stop',true))`).
* Expose parameters as a simple **GUI** (sliders for radii and speeds) or a configuration section at the top of the script.

---

## Reference (Optional Reading)

A short introductory paper on procedural generation of maze‑like levels is included in other projects; while not directly related to orbits, it illustrates how to frame algorithmic visuals as reproducible demos. If interested, see `docs/Search-Based Procedural Generation of Maze-Like Levels.pdf` in the maze project.

---

## License

MIT (add a `LICENSE` file if you plan to publish).
