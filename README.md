# SweetShapery

[![visionOS](https://img.shields.io/badge/visionOS-26.1%2B-000000?logo=apple)](https://developer.apple.com/visionos/)
[![Swift](https://img.shields.io/badge/Swift-5-F05138?logo=swift&logoColor=white)](https://swift.org)
[![RealityKit](https://img.shields.io/badge/RealityKit-3D-0A84FF)](https://developer.apple.com/documentation/realitykit)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

A visionOS app for previewing holiday cookie-cutter shapes in 3D, inside a full immersive space.

## Table of Contents

- [About](#about)
- [Features](#features)
- [Built With](#built-with)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Team](#team)
- [License](#license)

## About

SweetShapery lets you pick a cookie-cutter shape from a sidebar and inspect it as a
3D model floating in your space. The models were built in Reality Composer Pro and
loaded through a local `RealityKitContent` package. It was built by a team of three as a
short Apple Vision Pro prototype at the Apple Developer Academy | Mackenzie.

## Features

- Eight shapes: circle, square, pentagon, hexagon, octagon, star, Christmas tree and gingerbread man
- Full immersive space opened and dismissed from the main window
- Drag to move, pinch to scale and rotate, all as simultaneous gestures
- Live 2D preview of the selected shape in the sidebar

## Built With

- SwiftUI
- RealityKit and Reality Composer Pro (`.usdc` models)
- MVVM (`ShapeViewModel`)

## Getting Started

Requirements: Xcode 26 or later with the visionOS 26.1 SDK. Runs on the Apple Vision
Pro simulator or a device.

```bash
git clone https://github.com/EnzoFerroni/SweetShapery.git
cd SweetShapery
open SweetShapery.xcodeproj
```

Select a visionOS destination and press Run.

## Project Structure

```
SweetShapery/
├── SweetShaperyApp.swift      App entry point, window and immersive space
├── ContentView.swift          Main window
├── Models/CutterShape.swift   Shape catalog (names, SF Symbols, model files)
├── ViewModels/                ShapeViewModel (selection, scale, rotation)
└── Views/                     Sidebar, preview, controls, immersive view
Packages/RealityKitContent/    3D models and Reality Composer Pro scene
```

## Team

<div align="center">
  <table>
    <tr>
      <td align="center" width="33%">
        <a href="https://github.com/carolssun"><img src="https://github.com/carolssun.png" width="90" alt="Carolina Sun"/></a>
        <br/><sub><b>Carolina Sun</b></sub><br/><br/>
        <a href="https://github.com/carolssun"><img src="https://skillicons.dev/icons?i=github" alt="GitHub"/></a>
        <a href="https://www.linkedin.com/in/carolina-sun/"><img src="https://skillicons.dev/icons?i=linkedin" alt="LinkedIn"/></a>
      </td>
      <td align="center" width="33%">
        <a href="https://github.com/EmanuelaCaetano"><img src="https://github.com/EmanuelaCaetano.png" width="90" alt="Emanuela Caetano"/></a>
        <br/><sub><b>Emanuela Caetano</b></sub><br/><br/>
        <a href="https://github.com/EmanuelaCaetano"><img src="https://skillicons.dev/icons?i=github" alt="GitHub"/></a>
        <a href="https://www.linkedin.com/in/emanuela-caetano/"><img src="https://skillicons.dev/icons?i=linkedin" alt="LinkedIn"/></a>
      </td>
      <td align="center" width="33%">
        <a href="https://github.com/EnzoFerroni"><img src="https://github.com/EnzoFerroni.png" width="90" alt="Enzo Ferroni"/></a>
        <br/><sub><b>Enzo Ferroni</b></sub><br/><br/>
        <a href="https://github.com/EnzoFerroni"><img src="https://skillicons.dev/icons?i=github" alt="GitHub"/></a>
        <a href="https://www.linkedin.com/in/enzoferroni/"><img src="https://skillicons.dev/icons?i=linkedin" alt="LinkedIn"/></a>
      </td>
    </tr>
  </table>
</div>

## License

Released under the [MIT License](LICENSE). Copyright (c) 2025 Carolina Sun, Emanuela
Caetano and Enzo Ferroni.
