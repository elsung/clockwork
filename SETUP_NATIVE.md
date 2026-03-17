# Native App Setup (Mac Widget + Apple Watch)

## Prerequisites

Install **Xcode** from the Mac App Store.

## Create the Xcode Project

1. Open Xcode → **File → New → Project**
2. Choose **Multiplatform → App**
3. Name: `WorldClock`
4. Organization Identifier: pick yours (e.g. `com.yourname`)
5. Save it inside this repo folder

## Add the Source Files

1. In Xcode, delete the auto-generated `ContentView.swift`
2. Drag these files into the project navigator:
   - `WorldClock/Shared/WorldClockData.swift` — add to **all targets**
   - `WorldClock/Shared/CityClockView.swift` — add to **all targets**
   - `WorldClock/WorldClockApp.swift` — add to **iOS** and **macOS** targets

## Add the Widget Extension

1. **File → New → Target**
2. Choose **Widget Extension**
3. Name: `WorldClockWidget`
4. Uncheck "Include Live Activity" and "Include Configuration App Intent"
5. Replace the generated Swift file with `WorldClock/Widget/WorldClockWidget.swift`
6. Also add `WorldClockData.swift` and `CityClockView.swift` to the widget target

## Add the watchOS App

1. **File → New → Target**
2. Choose **watchOS → App**
3. Name: `WorldClockWatch`
4. Replace the generated view with `WorldClock/WatchApp/WorldClockWatchView.swift`
5. Add `WorldClockData.swift` to the watch target

## Build & Run

- **Mac widget**: Build the widget target, then add from Notification Center
- **iPhone**: Build & run the iOS target
- **Apple Watch**: Build & run the watchOS target, or add widget to watch face

## Deployment Targets

- macOS 14.0+ (for widget support)
- iOS 17.0+
- watchOS 10.0+
