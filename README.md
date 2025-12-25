# Godot Player Controller Demo Worlds

This project is a **starter framework** for rapidly prototyping game ideas in Godot without rebuilding core movement systems every time.

Instead of starting from a blank scene, this demo provides **three ready-to-use player controllers**, each paired with a simple demo world to validate movement, camera behavior, and feel.

The goal is not content — it’s **momentum**.

---

## 🧩 What’s Included

### 🎮 Player Controllers
- **2D Top-Down Player**
  - Free movement on X/Y
  - No gravity
  - Designed for RPGs, shooters, management sims, and exploration games

- **2D Platformer Player**
  - Gravity-based movement
  - Jumping and horizontal control
  - Designed for platformers and metroidvania-style games

- **3D FPS Player**
  - Mouse-look camera
  - WASD movement
  - Jump, sprint, crouch
  - Designed for FPS, first-person exploration, and tactical games

Each controller is built as a **self-contained scene** so it can be dropped into other projects without refactoring.

---

## 🌍 Demo Worlds

Each player has a corresponding demo world:

- **TopDown_World**
- **Platformer_World**
- **FPS_World**

These worlds exist purely to:
- Validate movement
- Test input
- Check camera behavior
- Confirm physics and collisions

They are intentionally simple and disposable.

---

## 🎯 Purpose of This Project

This repo exists to solve one problem:

> **Never start a game idea from nothing again.**

By keeping stable, reusable player controllers and demo environments:
- New ideas can be tested immediately
- Movement bugs don’t get reintroduced
- Creative energy goes into design, not setup

Assets, polish, and content are added later — *after* the idea proves itself.

---

## 🛠️ How to Use

1. Clone or download the repository
2. Open the project in Godot
3. Run any demo world scene
4. When starting a new game:
   - Copy the relevant player scene
   - Copy the corresponding demo world (optional)
   - Build on top of the framework

No engine modifications required.

---

## 📌 Design Philosophy

- Simple over clever
- Explicit over magical
- Frameworks first, content later
- Reuse systems, don’t rewrite them

This project is meant to evolve alongside future games, not be “finished.”

---

## 🚧 What This Is *Not*

- A full game
- A visual showcase
- A one-size-fits-all solution
- An asset pack

It’s a **foundation**.

---

## 🧠 Future Expansion Ideas (Optional)
- AI using the same controllers
- Animation-driven movement layers
- Interaction systems
- Save/load scaffolding
- Controller swapping at runtime

---

Built for fast iteration, not perfection.
