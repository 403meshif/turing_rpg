# Turing RPG

A simple RPG game with a procedurally generated world, built using the Turing programming language.

## Overview

Turing RPG is an experimental game engine and world generator. It features a tile-based movement system, procedural wilderness generation, and a structured map transition system.

**Author:** meshif
**Current Version:** v00.00.11 (December 29, 2025)

---

## Features

- **Procedural World Generation:** Explorable wilderness maps are generated with random elements like flowers.
- **Map Transitions:** Seamlessly move between different maps (Castle, Town, Wilderness).
- **Collection System:** Collect flowers scattered throughout the world.
- **Collision System:** Includes non-walkable tiles (e.g., walls, water).
- **Debug Mode:** Toggleable developer mode for real-time coordinate and tile data.
- **Input Support:** Support for both keyboard (arrow keys) and mouse interaction.

---

## Controls

- **Arrow Keys:** Move the player or navigate the map.
- **ESC:** Exit the game.
- **Mouse:** Used in debug mode to inspect tile colors and coordinates.

---

## Getting Started

To run this game, you will need the **Turing** programming environment.

1. **Download Turing:** Available for free from [compsci.ca](http://compsci.ca/holtsoft).
2. **Open the Project:** Open `Turing RPG.t` in the Turing editor.
3. **Run:** Press the "Run" button or hit `F1`.

---

## Technical Specifications

### Map Format
The map files (`map`) use a custom binary-like format where data is represented by pairs of characters (e.g., `01`, `10`). Each map is 228 bytes long.

| Bytes | Description |
|---|---|
| 000 - 001 | **Map Type** (00: Dev, 01: Castle, 10: Wilderness) |
| 002 - 025 | **Exit Points** (12 pairs representing exit availability) |
| 026 - 227 | **Map Sprites** (10x10 grid of tile indices) |

### Exit Point Diagram
Exit points are indexed from top-left to bottom-right:
```
    01  02  03
    |   |   |
04--+-------+--05
    |       |
06--|       |--07
    |       |
08--+-------+--09
    |   |   |
    10  11  12
```

### Tile Index
Commonly used tiles in the `spritesheet.bmp`:
- **000:** Blank / Default
- **001:** Numbered Tiles (Reference)
- **021:** Castle Floor
- **031 - 057:** Road and Town Tiles (North, East, T-junctions, Corners, etc.)
- **018:** Flower (Collectible)
- **099:** Player Sprite

---

## Development History

- **v00.00.11 (2025-12-29):** Added map transitions, updated map help files, working on animated player sprites.
- **v00.00.10 (2025-12-19):** Code cleanup, split source into modules (`.tu` files), added mouse support and non-walkable tiles.
- **v00.00.06 (2025-12-15):** Flowers became collectible, reorganized movement/mapgen.
- **v00.00.05 (2025-12-14):** Major cleanup, added devmode, redrew `spritesheet.bmp`.
- **v00.00.04 (2025-12-09):** Added starting castle and castle tiles, added tile constants.
- **v00.00.03 (2025-12-05):** Added new tiles and random flower generation.
- **v00.00.02 (2025-12-05):** Added arrow navigation.
- **v00.00.01 (2025-11-24):** Initial project start.

---

## Roadmap & Ideas

- [ ] Complete animated player sprites for all directions.
- [ ] Implement monster spawning and combat system.
- [ ] Expand the "Main Town" area with NPCs and buildings.
- [ ] Implement a save/load system for player progress.
- [ ] Add sound effects and background music.
