
# MuseumBeacon
<p align="left">
  <img alt="Platform" src="https://img.shields.io/badge/iOS-38761d?style=for-the-badge&style=plastic"/>
  <img alt="Language" src="https://img.shields.io/badge/Swift-f75c25?style=for-the-badge&logo=swift&logoColor=white&style=plastic"/>
</p>

Detect various iBeacons placed in museum exhibition rooms and show associated information.

An indoor guide app built around iBeacons. Walk into a room and the app recognizes the closest beacon, shows information about where you are, and reads it out loud, completely hands-free. Currently configured for one of my personal spaces.


## Features

- 🎧 **Automatic Guide Mode**: points of interest are announced with text-to-speech as you walk into them, with a light haptic tap on each room change
- 🧭 **Compass-relative directions**: arrows to nearby rooms rotate with the direction you're facing (CoreMotion heading)
- 🗺️ **Suggested paths**: step-by-step routes from your position to key destinations (reception, auditorium, exit, etc.)
- 📍 **All Points of Interest**: browse every room with photos, descriptions, and extra info
- 🏢 **Full Floor Map** of the level
- 📅 **Daily Calendar**: hour-by-hour timeline of events
- ♿ **VoiceOver friendly**: accessibility labels throughout, and speech is coordinated with VoiceOver announcements
- 🛠️ **Beacon testing view**: see every beacon in range with its UUID and estimated distance


## How it works

`BeaconDetector` ranges every beacon defined in `BeaconSetup` using CoreLocation. To avoid flickering between rooms when signals overlap:

- the last **3** distance readings for each beacon are averaged
- the closest beacon must win **6** consecutive detections before the app switches rooms

Once a room change is confirmed, the room name + description are spoken with `AVSpeechSynthesizer`, and nearby room directions are recalculated against the current compass heading.


## Getting Started

### Requirements
- Xcode 15+
- iOS 17+
- A **physical iPhone**. Beacon ranging doesn't work in the Simulator
- iBeacon hardware (any standard iBeacon works)

### Setup
1. Clone the repo & open `MuseumBeacon.xcodeproj`
2. 📝 Edit **[BeaconSetup.swift](../main/MuseumBeacon/Utils/BeaconSetup.swift)** with your own beacons. Each entry has:
   - `uuidString`: your beacon's UUID
   - `roomName`, `subtitle`, `description`, `moreInformation`: what's shown and read out loud
   - `imageName`: an image in the asset catalog
   - `nearbyRooms`: neighbouring rooms + compass direction (`"NORTH"`, `"SOUTHEAST"`, ...)
   - `suggestedPaths`: destination → list of rooms to walk through
3. Run on your device & allow location access ("Always" works best)
4. Use **Test Beacon Connections** to check that all your beacons are being picked up


Built with SwiftUI & Love.

[More on me](https://raviheyne.com "More on me")
