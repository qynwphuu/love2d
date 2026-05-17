## About

**Little Planet RPG** is a cozy, retro-style 2D top-down adventure game built with the Love2D framework. You play as a small alien explorer wandering through a pixel-art village — think classic handheld RPG vibes, but with a bit more charm.

On the technical side, the project is built around a few core systems: sprite animation sheets, Tiled map integration using the STI library, and a camera that smoothly follows the player while staying within the map boundaries. The pixel rendering is handled carefully to keep everything crisp and aligned, which matters a lot for this kind of art style.
It's primarily a learning-driven project focused on nailing the fundamentals of 2D game development — tile-based maps, animation state management, and camera behavior rather than shipping a full game. The result is a small but solid foundation that captures that classic top-down RPG feel.

---

## How to Run the Game

### Prerequisites

Before running the game, ensure you have **Love2D** installed on your system.

* Download it from the official website: [love2d.org](https://love2d.org/)

### Installation & Execution

#### Windows

#### Using VS Code (Recommended for Development)
1. Open the project folder in Visual Studio Code.
2. Make sure you have the Love2D Support extension installed.
3. Press Alt + L to launch the game instantly.

#### Running via Love2D Executable
1. Clone or download this repository to your local machine.
2. Select all the files inside the project root folder (including `main.lua`, `conf.lua`, `libraries/`, `maps/`, and `sprites/`).
3. Drag and drop the selected files directly onto your `love.exe` shortcut or application window.

* *Alternative:* Open your command prompt, navigate to the project directory, and run:
```bash
love .

```
*(Note: Requires love to be added to your system's PATH)*



#### macOS / Linux

1. Open your terminal.
2. Navigate to the root directory of the project where `main.lua` is located:
```bash
cd path/to/your/game-folder

```


3. Run the game using the love command:
```bash
love .

```



### Controls

 **Arrow Keys / WASD:** Move the character around the map.

---

## Credits
> - Assets by [Kenney](https://kenney.nl) (CC0)
> - Libraries: STI, camera.lua (hump), anim8 — all MIT licensed
