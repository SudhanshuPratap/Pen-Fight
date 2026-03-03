🖊️ Pen Fight

A turn-based 2-player physics game built using SwiftUI + SpriteKit.

Inspired by the classic classroom pen battle game, this project recreates the experience digitally with realistic impulse and rotational mechanics. The goal is simple: push your opponent’s pen out of the arena before yours goes out.

🎮 Gameplay

Pen Fight is a competitive, skill-based physics game.

Each player takes turns applying force to their pen inside a bounded arena.

Where you apply the force changes how the pen moves:

🎯 Hit near the center → more linear movement

🌀 Hit near the edge → more rotational spin (torque)

💥 Apply stronger drag → stronger impulse

The first player to reach the winning score wins the match.

👥 Players

2 Players (Blue vs Red)

Turn-based system

Score tracking per round

Automatic round reset after ring-out

🧠 Core Mechanics
🔹 Physics-Based Interaction

Custom impulse application using applyImpulse(_:at:)

Torque variation based on hit position

Compound physics bodies (barrel + cap)

Tuned friction and angular damping

Collision detection between pens and arena wall

🔹 Turn System

Turn locks while objects are moving

Automatically switches once both pens stop

Visual feedback for active player

🔹 Ring-Out Detection

Arena boundary check

Opponent scores when a pen exits

Winner detection after reaching max score

🏗 Architecture

The project separates UI, physics, and state management for clarity and maintainability.

Sources/
 ├── GameScene.swift      // SpriteKit physics & gameplay logic
 ├── GameState.swift      // Score and turn management
 ├── GameView.swift       // SwiftUI container for SpriteKit scene
 ├── MenuView.swift       // Start screen
 ├── ScoreCardView.swift  // Bottom score display
 ├── WinnerView.swift     // Match winner overlay
 └── Pen_FightApp.swift   // App entry point
Design Principles

Clear separation of concerns

Declarative UI using SwiftUI

Real-time physics using SpriteKit

Fully offline experience

Minimalist Apple-inspired interface

🛠 Technologies Used

SwiftUI – UI layout and structure

SpriteKit – Physics simulation and rendering

Combine – State management (ObservableObject)

Swift Playground (.swiftpm) format

No external libraries were used.
The project runs entirely offline.

▶️ Running the Project
Using Xcode

Open PenFight.swiftpm in Xcode 26 or later.

Select an iPhone simulator.

Press Run.

Using Swift Playgrounds (Mac / iPad)

Open the .swiftpm file.

Tap Run.

No internet connection is required.

🎯 Project Goal

This project explores how force application affects motion and rotation in a controlled environment. It focuses on:

Understanding impulse and torque

Creating skill-based gameplay mechanics

Maintaining clean architecture

Delivering a complete interactive experience within 3 minutes

The aim was not to create a complex game, but a focused and technically thoughtful one.

👤 Author
Sudhanshu Pratap
