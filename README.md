# A Nice Day

A minimal, journal-like iOS app that asks one simple question each day: **"Did you enjoy the weather today?"**

## Overview

This SwiftUI app helps users track their daily weather experiences in a calm, non-judgmental way. It doesn't assess whether the weather was objectively "good" – it records whether you personally enjoyed it.

## Features

### Core Functionality
- 📝 **Daily Prompt**: One question per day with Yes/No response
- 🌤️ **Weather Tracking**: Automatically captures temperature, conditions, humidity, wind speed, and more
- 📍 **Location Logging**: Records human-readable location (city, state, country)
- 💾 **Local Storage**: All data stored locally using Core Data
- 🔒 **Privacy First**: No raw coordinates exposed in UI

### User Interface
- **Home Screen**: Daily prompt with intuitive Yes/No buttons
- **History View**: Browse all past entries with visual distinction
- **Year Summary**: Statistics showing enjoyment patterns and weather correlations
- **Calm Design**: Minimal, journal-like aesthetic with soft gradients

### Technical Features
- SwiftUI + MVVM architecture
- Core Data for persistence
- CoreLocation for location services
- WeatherKit integration (with mock service fallback)
- Proper error handling for permissions and network failures

## Architecture

```
ANiceDay/
├── Models/
│   ├── WeatherEntry.swift       # Core Data entity
│   └── WeatherData.swift        # Weather & location data structures
├── Services/
│   ├── PersistenceService.swift # Core Data management
│   ├── LocationService.swift    # CoreLocation wrapper
│   └── WeatherService.swift     # Weather data fetching
├── ViewModels/
│   ├── HomeViewModel.swift      # Home screen logic
│   ├── HistoryViewModel.swift   # History screen logic
│   └── YearSummaryViewModel.swift # Statistics logic
└── Views/
    ├── HomeView.swift           # Daily prompt screen
    ├── HistoryView.swift        # Past entries list
    ├── EntryDetailView.swift    # Single entry details
    └── YearSummaryView.swift    # Yearly statistics
```

## Setup Instructions

### Requirements
- Xcode 15.0 or later
- iOS 17.0 or later
- Swift 5.9 or later

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Lexieeagleson/A-nice-day.git
cd A-nice-day
```

2. Open in Xcode:
```bash
open Package.swift
```

3. Build and run:
   - Select your target device/simulator
   - Press Cmd+R to build and run

### WeatherKit Setup (Optional)

To use real weather data instead of mock data:

1. Add WeatherKit capability in Xcode:
   - Select your project in the navigator
   - Go to "Signing & Capabilities"
   - Click "+ Capability"
   - Add "WeatherKit"

2. Update HomeViewModel initialization:
```swift
weatherService: WeatherService(useWeatherKit: true)
```

3. Note: WeatherKit requires:
   - A valid Apple Developer account
   - Proper entitlements configured
   - Testing on a physical device or simulator with internet

## Usage

### First Launch
1. App will request location permission
2. Grant "Allow While Using App" for full functionality
3. If denied, app will still work but location/weather will be marked as unavailable

### Daily Logging
1. Open the app to see today's prompt
2. Tap "Yes" or "No" to record your response
3. App automatically fetches location and weather data
4. Can only log once per day
5. Today's result is displayed after logging

### Viewing History
1. Tap "History" tab to see all past entries
2. Each entry shows date, location, weather, and your response
3. Tap any entry to see full details
4. Swipe left to delete entries

### Checking Statistics
1. Tap "Summary" tab for yearly overview
2. View total days logged, enjoyed vs not enjoyed
3. See weather patterns associated with enjoyment
4. Switch years using the calendar icon

## Data Storage

All data is stored locally on your device using Core Data:

- **One entry per calendar day** (prevents duplicate logs)
- **Persistent across app launches**
- **No cloud sync** (completely private)

Each entry includes:
- Date and time
- Yes/No response
- Location name
- Temperature (current, high, low)
- Weather condition
- Precipitation
- Humidity
- Wind speed
- Weather description

## Permissions

### Location (Required for full functionality)
- **Why**: To fetch weather data for your current location
- **What's stored**: Human-readable city name (e.g., "San Francisco, CA, USA")
- **What's NOT stored**: Raw GPS coordinates
- **When**: Only when you submit a daily response

### WeatherKit (Optional)
- **Why**: To fetch real-time weather data
- **Alternative**: App uses mock weather service if unavailable

## Privacy

- All data stored locally on your device
- No analytics or tracking
- No data sent to third parties
- Location stored as human-readable text only
- No account or login required

## Future Enhancements

Potential features for future versions:
- Daily notification reminders
- CSV export for yearly data
- Calendar heatmap visualization
- Additional weather metrics
- Multi-year comparison charts

## Development

### Running Tests
```bash
swift test
```

### Code Style
- SwiftUI for all views
- MVVM architecture pattern
- Async/await for asynchronous operations
- Clear separation of concerns
- Comprehensive inline documentation

## License

See LICENSE file for details.

## Contributing

This is a personal project, but suggestions and feedback are welcome through issues.

## Contact

For questions or feedback, please open an issue on GitHub.
