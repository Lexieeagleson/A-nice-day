# Code Architecture Documentation

## Overview

A Nice Day follows a clean MVVM (Model-View-ViewModel) architecture with clear separation between data, business logic, and presentation layers.

## Architecture Layers

### 1. Models (`Models/`)

**Purpose**: Define data structures and Core Data entities

#### WeatherEntry.swift
- Core Data entity representing a daily log entry
- Stores user response, date, location, and weather data
- Key properties:
  - `enjoyedWeather: Bool` - User's yes/no response
  - `date: Date` - Timestamp of entry
  - `locationName: String?` - Human-readable location
  - Weather metrics (temperature, humidity, wind, etc.)
- Provides fetch requests for querying entries

#### WeatherData.swift
- Lightweight struct for weather information
- Used to pass weather data from service to persistence
- Codable for potential future network/storage needs
- Contains: temperature, highs/lows, condition, precipitation, humidity, wind

**LocationData.swift** (also in WeatherData.swift)
- Represents a location with human-readable name
- Stores lat/long for weather API calls
- Displays only name in UI (privacy-focused)

---

### 2. Services (`Services/`)

**Purpose**: Handle external integrations and data operations

#### PersistenceService.swift
**Responsibility**: Core Data management

- Singleton pattern (`shared` instance)
- Creates Core Data model programmatically
- Provides CRUD operations:
  - `createEntry()` - Save new daily log
  - `fetchTodayEntry()` - Check if logged today
  - `fetchAllEntries()` - Get all entries
  - `delete()` - Remove an entry
- Thread-safe with main context for UI

**Key Design Decision**: Programmatic model creation instead of .xcdatamodeld file for better version control and portability.

#### LocationService.swift
**Responsibility**: Location access and geocoding

- Wraps CoreLocation APIs
- Observable object for permission status
- Async/await for location fetching
- Reverse geocoding to human-readable names
- Graceful failure handling

**Flow**:
1. Request permission on first use
2. Fetch current coordinates
3. Reverse geocode to city/state/country
4. Return LocationData or nil if denied

**Error Handling**:
- Permission denied → returns nil, continues without location
- Geocoding failed → uses "Unknown Location"
- Location unavailable → returns nil, marks as unavailable

#### WeatherService.swift
**Responsibility**: Weather data fetching

**Design Pattern**: Protocol-based abstraction
- `WeatherServiceProtocol` defines interface
- `WeatherKitService` - Real implementation using Apple's WeatherKit
- `MockWeatherService` - Simulated data for testing
- `WeatherService` - Coordinator wrapping implementation

**Why this design?**
- Easy to swap implementations
- Can add OpenWeatherMap, Weather.gov, etc.
- Testing without real API calls
- No changes needed in ViewModels

**WeatherKit Integration**:
```swift
let weather = try await service.weather(for: clLocation)
let current = weather.currentWeather
let daily = weather.dailyForecast.first
// Combine into WeatherData struct
```

---

### 3. ViewModels (`ViewModels/`)

**Purpose**: Business logic, state management, connecting services to views

#### HomeViewModel.swift
**Responsibility**: Daily prompt and entry creation

**State**:
- `todayEntry` - Current day's entry (if exists)
- `isLoading` - Show/hide loading indicator
- `errorMessage` - Display error alerts

**Key Methods**:
- `loadTodayEntry()` - Check if already logged today
- `submitResponse(enjoyedWeather: Bool)` - Handle user response
  1. Set loading state
  2. Fetch location asynchronously
  3. Fetch weather asynchronously
  4. Create and save entry
  5. Update UI state

**Flow**:
```
User taps Yes/No
    → submitResponse() called
    → Fetch location (may fail gracefully)
    → Fetch weather (may fail gracefully)
    → Save to Core Data
    → Update todayEntry
    → UI reflects new state
```

#### HistoryViewModel.swift
**Responsibility**: Display and manage past entries

**Simple design**:
- Loads all entries on appear
- Provides delete functionality
- Groups entries by year for organization

#### YearSummaryViewModel.swift
**Responsibility**: Calculate statistics and patterns

**Computed Properties**:
- `totalDays` - Count of entries
- `enjoyedDays` / `notEnjoyedDays` - Yes/No counts
- `enjoymentPercentage` - Success rate
- `averageTempOnEnjoyedDays` - Temperature correlation
- `mostCommonEnjoyedCondition` - Weather pattern analysis

**Design**: All calculations done in real-time from entries array (no caching needed for small datasets)

---

### 4. Views (`Views/`)

**Purpose**: SwiftUI user interface components

#### ANiceDayApp.swift
**Entry point**: Defines app lifecycle

- Creates PersistenceService on launch
- Injects Core Data context into environment
- Sets up TabView navigation

#### HomeView.swift
**Daily prompt screen**

**States**:
1. **Not logged**: Shows question with Yes/No buttons
2. **Already logged**: Shows today's result with details

**UI Elements**:
- Gradient background (calm aesthetic)
- Large icons for emotional connection
- Loading overlay when fetching data
- Error alerts for failures

**Component**: DetailRow - Reusable info display with icon

#### HistoryView.swift
**Past entries list**

**Features**:
- Empty state when no entries
- List of entries with swipe-to-delete
- Visual distinction (thumbs up/down icons)
- Navigation to detail view

**Component**: EntryRow - Each list item showing summary

#### EntryDetailView.swift
**Single entry details**

**Layout**:
- Header with response and date
- Location section (if available)
- Weather details section
- Description section

**Components**:
- SectionCard - Grouped information container
- InfoRow - Key-value pair display

#### YearSummaryView.swift
**Statistics and patterns**

**Visualizations**:
- Stat cards for totals
- Circular progress for percentage
- Pattern rows for weather correlations

**Features**:
- Year selector in toolbar
- Empty state for no data
- Color coding (blue = enjoyed, gray = not enjoyed)

---

## Data Flow

### Logging a Daily Entry

```
HomeView
    ↓ User taps button
HomeViewModel.submitResponse()
    ↓ Async call
LocationService.fetchLocation()
    ← Returns LocationData or nil
    ↓ Async call
WeatherService.fetchWeather()
    ← Returns WeatherData or nil
    ↓ Sync call
PersistenceService.createEntry()
    ↓ Saves to Core Data
    ↓ Updates state
HomeViewModel.todayEntry = newEntry
    ↓ SwiftUI binding
HomeView refreshes UI
```

### Viewing History

```
HistoryView appears
    ↓
HistoryViewModel.loadEntries()
    ↓
PersistenceService.fetchAllEntries()
    ← Returns [WeatherEntry]
    ↓
HistoryViewModel.entries updated
    ↓ SwiftUI binding
HistoryView displays list
```

---

## Key Design Decisions

### 1. One Entry Per Day
- Enforced at persistence layer
- Check performed before showing prompt
- Prevents accidental duplicate logs

### 2. Graceful Degradation
- Location denied? → Entry saved without location
- Weather unavailable? → Entry saved with placeholder
- Network error? → User sees error but can retry

### 3. Privacy-First
- No raw coordinates in UI
- All data stored locally (no cloud sync)
- Human-readable location only

### 4. Separation of Concerns
- Services don't know about UI
- ViewModels don't know about Core Data details
- Views don't directly call services

### 5. Mock Services
- Development without real APIs
- Faster testing
- No API keys needed initially

---

## Extension Points

### Adding a New Weather Service

1. Create class conforming to `WeatherServiceProtocol`
2. Implement `fetchWeather(for:)` method
3. Update `WeatherService` init to use new implementation

Example:
```swift
class OpenWeatherMapService: WeatherServiceProtocol {
    func fetchWeather(for location: LocationData) async throws -> WeatherData {
        // Call OpenWeatherMap API
        // Parse response
        // Return WeatherData
    }
}
```

### Adding New Statistics

1. Add computed property to `YearSummaryViewModel`
2. Update `YearSummaryView` to display new stat
3. No changes needed elsewhere

Example:
```swift
// In YearSummaryViewModel
var mostEnjoyedMonth: String? {
    // Calculate from entries
}
```

### Adding Notifications

1. Create `NotificationService` in Services/
2. Request permission in AppDelegate or App
3. Schedule daily reminder
4. Handle notification actions

---

## Testing Strategy

### Unit Tests
- Model creation (WeatherData, LocationData)
- Service mocking (MockWeatherService)
- ViewModel logic (statistics calculations)

### Integration Tests
- Core Data persistence
- Location service with mock CLLocationManager
- Full entry creation flow

### UI Tests
- Navigation between screens
- Entry creation workflow
- Error state handling

---

## Performance Considerations

### Core Data
- Single persistent container
- Main context for UI operations
- Automatic merging from parent context

### Location/Weather
- Async/await prevents UI blocking
- Timeout handling for network calls
- Cancellation support for user navigation

### UI Rendering
- SwiftUI's automatic optimization
- List virtualization for history
- Lazy loading of detail views

---

## Error Handling

### Location Errors
- Permission denied → Continue without location
- Location unavailable → Store nil
- Geocoding failed → Use "Unknown Location"

### Weather Errors
- Network error → Retry option
- API failure → Use placeholder data
- Timeout → Show error message

### Persistence Errors
- Save failure → Alert user
- Fetch failure → Show empty state
- Duplicate entry → Prevent at UI level

---

## Future Enhancements

### Potential Additions
1. **Export Feature**: CSV generation from entries
2. **Charts**: Calendar heatmap, bar charts
3. **Notifications**: Daily reminder at user-set time
4. **Themes**: Dark mode, custom colors
5. **Widgets**: Today at a glance
6. **CloudKit**: Optional sync across devices
7. **Insights**: ML-based pattern detection

### Refactoring Opportunities
1. Extract reusable UI components into separate files
2. Add dependency injection container
3. Implement repository pattern for data layer
4. Add logging framework for debugging

---

## Common Tasks

### Adding a New View Model Property

1. Add `@Published` property
2. Update loading method
3. Bind in corresponding view
4. Handle state changes

### Modifying Weather Data Structure

1. Update `WeatherData` struct
2. Update `WeatherEntry` Core Data attributes
3. Update `PersistenceService.createEntry()`
4. Update UI to display new fields
5. Handle migration for existing data

### Changing UI Appearance

1. Locate view in `Views/` folder
2. Modify SwiftUI layout
3. Update colors, fonts, spacing
4. Test on different screen sizes
5. Verify accessibility

---

## Questions & Answers

**Q: Why programmatic Core Data model instead of .xcdatamodeld?**
A: Better for version control, easier to review in PRs, and works in Swift Package Manager.

**Q: Why separate WeatherData and WeatherEntry?**
A: WeatherData is ephemeral (from API), WeatherEntry is persistent (in database). Separation of concerns.

**Q: Why mock weather by default?**
A: Easier development without API keys, faster testing, works offline.

**Q: Can I add more weather providers?**
A: Yes! Implement `WeatherServiceProtocol` and swap in `WeatherService` init.

**Q: How do I reset the database?**
A: Delete and reinstall the app. Core Data store is removed with the app.

---

For more information, see individual file comments and the main README.md.
