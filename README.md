# Formal Specification of a Simplified Asteroids Arcade Game 🚀

## Project Overview
This project involves the formal specification of a simplified version of the classic **Asteroids Arcade Game**, created as part of the **Formal Methods** module at the **University of Westminster**. Using **B-Method**, I modeled and verified a system where a spaceship navigates through a grid-based space region, avoiding asteroids and optimizing power usage, while adhering to strict constraints.

---

## Features
- **Space Region Modeling**: A 12x7 grid representing the game space with clearly defined asteroids and safe zones.
- **Spaceship Operations**:
  - **Normal Moves**: Move up, down, left, or right, consuming 5 units of power per move.
  - **Warp-Drive**: Jump to any non-asteroid location, consuming 20 units of power.
  - **Collision Handling**: Lose power and reset to the previous location if colliding with an asteroid.
- **Game States**:
  - **Win**: Successfully dock at the starbase (6,4).
  - **Lose**: Run out of power before reaching the starbase.
  - **In Progress**: Continue navigating the space region.
- **Mission Queries**:
  - **MissionStatus**: Check the current game state, spaceship location, power, and collisions.
  - **RegionsVisited**: Track all regions traversed by the spaceship.

---

## Files in the Repository
- **`SpaceRegion.mch`**: Defines the game space, including the grid, asteroids, homebase, and starbase.
- **`Spaceship.mch`**: Specifies the spaceship's movements, power management, and game logic.
- **`SpaceRegion.prob`** and **`Spaceship.prob`**: ProB files for animating and validating the models.
- **`Report.pdf`**: A detailed explanation of the project, including the structure diagram and invariant descriptions.

---

## Tools Used
- **B-Method**: Formal specification language used to define the system.
- **Atelier B**: Tool for writing and checking B specifications.
- **ProB**: Model checker and animator to validate and simulate the system.

---

## Achievements
- **Grade Achieved: 97/100**.
- Successfully modeled and verified a robust system free from logical errors.
- Enhanced understanding of formal specification for real-world applications.

---

