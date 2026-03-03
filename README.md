# 🖊️ Pen Fight

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20iPadOS%20%7C%20macOS-lightgrey.svg)](https://developer.apple.com/platforms/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A turn-based 2-player physics game built with **SwiftUI** and **SpriteKit** — a digital recreation of the classic classroom pen battle game. Challenge a friend and test your precision in this minimalist physics showdown.

---

## 📋 Table of Contents
- [Overview](#-overview)
- [Gameplay](#-gameplay)
- [Core Mechanics](#-core-mechanics)
- [Architecture](#-architecture)
- [Technologies](#-technologies)
- [Setup](#-setup)
- [Project Goals](#-project-goals)
- [Author](#-author)
- [License](#-license)

---

## 🎯 Overview

Pen Fight brings the nostalgic classroom pen battle to your device with realistic physics and competitive gameplay. Two players take turns applying carefully aimed impulses to their pens, trying to knock the opponent out of the arena while keeping their own pen in play. Every hit matters — where and how you strike determines the outcome.

---

## 🎮 Gameplay

### Basic Rules

| Rule | Description |
|------|-------------|
| **Players** | 2 Players (Blue vs Red), turn-based competition |
| **Objective** | Push opponent's pen outside the arena boundaries |
| **Win Condition** | First player to reach **3 points** wins the match |
| **Round Reset** | Automatic repositioning after each ring-out |

### Turn System

- **Active Player** — Visual highlight indicates whose turn it is
- **Movement Lock** — No turns while pens are in motion
- **Auto Switch** — Turn passes automatically when both pens settle

### Scoring

- **+1 Point** for forcing opponent out of bounds
- **Match Victory** at 3 points with celebration overlay
- **Score Reset** for new matches

---

## ⚙️ Core Mechanics

### 🔹 Physics Engine (SpriteKit)

The game simulates realistic pen behavior using compound physics bodies:
┌─────────────────────────────────────┐
│ PEN STRUCTURE │
├─────────────────────────────────────┤
│ ┌─────────────────────────────┐ │
│ │ MAIN BARREL │ │
│ │ • Mass: Optimized balance │ │
│ │ • Friction: Controlled │ │
│ │ • Angular Damping: Realistic│ │
│ └─────────────────────────────┘ │
│ ⬇️ │
│ ┌─────────────────────────────┐ │
│ │ CAP │ │
│ │ • Joint connection to barrel│ │
│ └─────────────────────────────┘ │
└─────────────────────────────────────┘

text

### 🔹 Impulse System

Players control force application through intuitive touch:

| Hit Location | Primary Effect | Gameplay Impact |
|:------------:|:--------------:|:----------------|
| **Center** | Linear thrust | Quick pushes, repositioning |
| **Near Edge** | Torque + rotation | Spin attacks, tricky shots |
| **Strong Drag** | High impulse | Powerful knockback |
| **Light Tap** | Gentle nudge | Precision adjustments |

### 🔹 Collision Detection
┌─────────────────────────────────────┐
│ ARENA INTERACTIONS │
├─────────────────────────────────────┤
│ • Pen-to-Pen → Bounce + momentum │
│ • Pen-to-Wall → Energy loss │
│ • Ring-out → Continuous monitoring
└─────────────────────────────────────┘

text

### 🔹 Arena Environment

- **Bounded rectangular playing field**
- **Optimized friction** for strategic movement
- **Clear visual boundaries**

---

## 🏗 Architecture

The project follows clean architecture principles with clear separation between UI, physics, and game state.

### Directory Structure
Pen-Fight/
├── Sources/
│ ├── Pen_FightApp.swift # App entry point
│ ├── Views/
│ │ ├── MenuView.swift # Start screen
│ │ ├── GameView.swift # SwiftUI + SpriteKit container
│ │ ├── ScoreCardView.swift # Score display
│ │ └── WinnerView.swift # Victory overlay
│ ├── Game/
│ │ ├── GameScene.swift # Physics & core gameplay
│ │ └── GameState.swift # Turn & score management
│ └── Resources/
│ └── Assets.xcassets # Icons & visuals
└── PenFight.swiftpm # Swift Playground package

text

### Key Design Patterns

| Pattern | Implementation | Purpose |
|:--------|:---------------|:--------|
| **MVVM** | SwiftUI Views + ObservableObject | Clean UI state management |
| **Observer** | Combine framework | Real-time score updates |
| **State Machine** | GameState enum | Turn & match flow control |
| **Delegate** | SKSceneDelegate | Physics-view communication |

### Data Flow
User Input → GameScene (Touch) → Physics Simulation → GameState → SwiftUI Views
↑ ↓
└─────────────────── Continuous Loop ───────────────────────┘

text

---

## 🛠 Technologies

### Core Frameworks

| | | |
|:---:|:---:|:---:|
| **SwiftUI** | **SpriteKit** | **Combine** |
| 100% declarative UI | Physics simulation | Reactive state |
| **GameplayKit** | **Xcode 15+** | **Swift Playgrounds** |
| State machines | Primary IDE | iPad/Mac support |

### Key Features

✅ Zero external dependencies  
✅ Full offline functionality  
✅ Adaptive layout (iPhone/iPad/Mac)  
✅ 60 FPS physics simulation  
✅ Accessibility support  

---

## 🚀 Setup

### Prerequisites

- **iOS 16.0+** / **iPadOS 16.0+** / **macOS 13.0+**
- **Xcode 15.0+** (for development)
- **Swift Playgrounds 4.0+** (for iPad)

### Installation Options

#### Option 1: Xcode (Recommended for Development)
```bash
# Clone the repository
git clone https://github.com/SudhanshuPratap/Pen-Fight.git

# Open in Xcode
cd Pen-Fight
open PenFight.swiftpm

# Press Cmd+R to run
Option 2: Swift Playgrounds (iPad/Mac)
Download the repository as ZIP

Extract and open PenFight.swiftpm

Tap "Run" to start playing

Option 3: Direct Download
Visit Releases

Download latest .swiftpm package

Open with preferred IDE

🎯 Project Goals
Educational Goals
Physics Understanding — Explore how impulse and torque affect rigid body dynamics

Framework Integration — Master SwiftUI + SpriteKit interoperability

State Management — Implement clean reactive patterns with Combine

Technical Goals
Clean Architecture — Maintain strict separation of concerns

Performance — Achieve consistent 60 FPS with complex physics

Reusability — Create modular components for future projects

Design Goals
Minimalist UI — Apple-inspired clean interface

Intuitive Controls — Natural drag-and-tap mechanics

Accessibility — VoiceOver and Dynamic Type support

Achievement Metrics
Metric	Target	Status
Package Size	📦 < 5 MB	✅ Achieved
Performance	⚡️ 60 FPS	✅ Achieved
Latency	🎯 < 100ms	✅ Achieved
Platform Support	📱 Universal	✅ Achieved
👤 Author
Sudhanshu Pratap
iOS Developer passionate about physics simulations and game mechanics

https://img.shields.io/badge/GitHub-@SudhanshuPratap-181717?style=flat-square&logo=github
https://img.shields.io/badge/LinkedIn-Sudhanshu_Pratap-0077B5?style=flat-square&logo=linkedin

Specialties:

🎯 SwiftUI & UIKit Development

🎮 SpriteKit & Game Physics

🥽 ARKit & RealityKit

🏗 Clean Architecture & Design Patterns

📄 License
This project is licensed under the MIT License - see the LICENSE file for details.

text
MIT License

Copyright (c) 2024 Sudhanshu Pratap

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
📊 Project Status
Phase	Status	Timeline
Core Mechanics	✅ Complete	v1.0
UI/UX Polish	✅ Complete	v1.1
Multiplayer	🚧 Planning	v2.0
AI Opponent	📝 Research	Future
🙏 Acknowledgments
Inspiration — Classroom pen fighting games from school days

Physics Guidance — Box2D and SpriteKit documentation

Design Inspiration — Apple's Game Center and traditional board games

<div align="center">
⭐ Star this repo if you found it useful!
Report Bug · Request Feature · Follow Author

Last Updated: March 2024 • Swift 5.9

</div> ``
