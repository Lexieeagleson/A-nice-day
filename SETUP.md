# Setting Up A Nice Day in Xcode

This guide explains how to properly open and run the A Nice Day iOS app in Xcode.

## Prerequisites

- **macOS** 13.0 or later
- **Xcode** 15.0 or later
- **iOS Device or Simulator** running iOS 17.0+

## Opening the Project

### Option 1: Using Swift Package (Recommended)

1. **Open Xcode**
2. Go to **File → Open**
3. Navigate to the `A-nice-day` folder
4. Select `Package.swift`
5. Click **Open**

### Option 2: Double-click Package.swift

Simply double-click the `Package.swift` file in Finder, and it will open in Xcode.

## Running the App

1. **Select a Target**:
   - In Xcode's toolbar, select either:
     - An iOS Simulator (e.g., "iPhone 15 Pro")
     - A connected iOS device

2. **Build and Run**:
   - Press `Cmd+R` or click the ▶️ Play button
   - The app will compile and launch

## Configuring WeatherKit (Optional)

To use real weather data instead of mock data:

### Step 1: Add WeatherKit Capability

1. Select your project in the navigator
2. Select the target
3. Go to **Signing & Capabilities** tab
4. Click **+ Capability**
5. Search for and add **WeatherKit**

### Step 2: Update Code

In `Sources/ANiceDay/ViewModels/HomeViewModel.swift`, change line 20:

```swift
// From:
weatherService: WeatherService(useWeatherKit: false)

// To:
weatherService: WeatherService(useWeatherKit: true)
```

### Step 3: Test on Device

WeatherKit requires:
- A valid Apple Developer account with WeatherKit enabled
- Testing on a physical device OR simulator with internet connection
- Proper entitlements configured in your developer portal

## Project Structure in Xcode

When opened, you'll see:

```
ANiceDay
├── Sources
│   └── ANiceDay
│       ├── ANiceDayApp.swift      (Entry point)
│       ├── Models/                (Data models)
│       ├── Services/              (Business logic)
│       ├── ViewModels/            (MVVM logic)
│       └── Views/                 (UI components)
├── Tests
│   └── ANiceDayTests
└── Package.swift                  (Package manifest)
```

## First Launch Experience

1. **Location Permission**:
   - On first launch, the app will request location permission
   - Select "Allow While Using App" for full functionality
   - Permission can be changed later in Settings → Privacy → Location Services

2. **Using the App**:
   - Home screen shows the daily prompt
   - Tap "Yes" or "No" to record your weather experience
   - App automatically fetches location and weather data
   - View history and statistics in other tabs

## Troubleshooting

### "No such module 'SwiftUI'" error

This happens when trying to build from command line. The app must be built in Xcode.

**Solution**: Open `Package.swift` in Xcode and build from there.

### WeatherKit not working

**Possible causes**:
- WeatherKit entitlement not added
- Not using a valid Apple Developer account
- Testing on simulator without internet
- Code still using mock service

**Solution**: Follow the "Configuring WeatherKit" steps above.

### Location permission denied

**Solution**: 
- Go to Settings → Privacy → Location Services
- Find "ANiceDay" and enable location access
- Restart the app

### Core Data errors

**Solution**:
- Delete the app from simulator/device
- Clean build folder (Cmd+Shift+K)
- Rebuild and run

## Building for Production

1. **Set up App ID**:
   - Go to developer.apple.com
   - Create an App ID with WeatherKit capability

2. **Configure Signing**:
   - In Xcode, select target → Signing & Capabilities
   - Select your team
   - Xcode will automatically provision

3. **Archive**:
   - Select "Any iOS Device" as target
   - Product → Archive
   - Follow App Store Connect upload process

## Development Tips

### Viewing Core Data

Use Xcode's Core Data debugging:
1. Run the app
2. Debug → View Memory Graph
3. Filter for "WeatherEntry" to see stored entries

### Resetting Data

To clear all entries during testing:
- Delete and reinstall the app
- Core Data store is removed with the app

### Mock vs Real Weather

The app uses mock weather by default for easier testing:
- Mock service returns simulated data instantly
- Real WeatherKit requires network and permissions
- Toggle in `HomeViewModel` initialization

## Next Steps

- Explore the codebase in `/Sources/ANiceDay/`
- Read inline documentation for each component
- Modify UI in SwiftUI views
- Add custom features or enhancements

For more information, see the main README.md file.
