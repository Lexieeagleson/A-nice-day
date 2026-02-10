# UI Design & User Experience

This document describes the visual design, user flows, and interaction patterns in A Nice Day.

## Design Philosophy

### Core Principles

1. **Calm & Minimal**: No overwhelming features or cluttered screens
2. **Journal-like**: Feels like a personal, reflective experience
3. **Non-judgmental**: No assessment of weather quality
4. **Intentional**: One action per day encourages mindfulness
5. **Private**: All data stays local, no sharing pressure

### Visual Language

- **Colors**: Soft blues and cyans (weather-inspired)
- **Backgrounds**: Subtle gradients (peaceful, not distracting)
- **Typography**: Clear hierarchy, readable fonts
- **Icons**: SF Symbols for consistency with iOS
- **Spacing**: Generous padding for breathing room

---

## Screen Breakdown

### 1. Home Screen (Daily Prompt)

#### State A: Before Logging

**Layout**:
```
┌─────────────────────────────┐
│     A Nice Day             │ Navigation Bar
├─────────────────────────────┤
│                             │
│         [cloud+sun          │ Large icon
│          icon]              │
│                             │
│   "Did you enjoy the"       │ Question
│   "weather today?"          │ (large, centered)
│                             │
│                             │
│   ┌─────────┐  ┌─────────┐ │ 
│   │   No    │  │   Yes   │ │ Buttons
│   │  (gray) │  │  (blue) │ │
│   └─────────┘  └─────────┘ │
│                             │
└─────────────────────────────┘
```

**Colors**:
- Background: Light blue gradient (top) to cyan (bottom)
- "No" button: Gray (#808080)
- "Yes" button: Blue (#007AFF)
- Text: Dark gray for question

**Interaction**:
1. User opens app
2. Sees question immediately
3. Taps Yes or No
4. Loading indicator appears
5. Transitions to State B

#### State B: After Logging

**Layout**:
```
┌─────────────────────────────┐
│     A Nice Day             │
├─────────────────────────────┤
│                             │
│         [thumbs up          │ Response icon
│          icon]              │ (or thumbs down)
│                             │
│   "You enjoyed"             │ Confirmation
│   "today's weather"         │
│                             │
│   ┌─────────────────────┐   │
│   │ 📅 Jan 15, 3:45 PM │   │ Date
│   │ 📍 San Francisco   │   │ Location
│   │ ☁️  Partly Cloudy  │   │ Condition
│   │ 🌡️  20.5°C        │   │ Temperature
│   └─────────────────────┘   │
│                             │
│   "See you tomorrow!"       │ Friendly message
│                             │
└─────────────────────────────┘
```

**Visual Distinctions**:
- Thumbs up (enjoyed): Blue icon
- Thumbs down (not enjoyed): Gray icon
- Info card: White background with slight transparency
- Icons in card: Small, blue SF Symbols

---

### 2. History Screen

#### Empty State

**Layout**:
```
┌─────────────────────────────┐
│       History              │
├─────────────────────────────┤
│                             │
│                             │
│       [calendar with        │
│        exclamation]         │
│                             │
│     "No entries yet"        │
│                             │
│  "Start logging your        │
│   weather experiences!"     │
│                             │
│                             │
└─────────────────────────────┘
```

#### With Entries

**Layout**:
```
┌─────────────────────────────┐
│       History              │
├─────────────────────────────┤
│ ┌─────────────────────────┐ │
│ │ 👍 January 15, 2026    │ │ Entry 1
│ │    San Francisco, CA   │ │ (enjoyed)
│ │    ☁️ Partly Cloudy 20°│ │
│ └─────────────────────────┘ │
│                             │
│ ┌─────────────────────────┐ │
│ │ 👎 January 14, 2026    │ │ Entry 2
│ │    Oakland, CA         │ │ (not enjoyed)
│ │    🌧️ Rainy · 12°C    │ │
│ └─────────────────────────┘ │
│                             │
│ ┌─────────────────────────┐ │
│ │ 👍 January 13, 2026    │ │ Entry 3
│ │    ...                 │ │
│ └─────────────────────────┘ │
└─────────────────────────────┘
```

**Visual Details**:
- Each entry is a card with rounded corners
- Background: White with 60% opacity
- Thumbs up/down icon on the left (large)
- Date in bold
- Location in secondary gray
- Weather condition with icon and temperature
- Tap entry → navigates to detail view
- Swipe left → reveals delete button

---

### 3. Entry Detail Screen

**Layout**:
```
┌─────────────────────────────┐
│          < Back            │
├─────────────────────────────┤
│                             │
│         [thumbs up]         │ Large icon
│                             │
│        "Enjoyed"            │ Status
│   January 15, 2026 3:45 PM │ Timestamp
│                             │
│   ┌─ Location ───────────┐  │
│   │ 📍 San Francisco, CA │  │
│   └─────────────────────┘   │
│                             │
│   ┌─ Weather Details ────┐  │
│   │ Condition: Partly... │  │
│   │ Temperature: 20.5°C  │  │
│   │ High / Low: 25 / 15  │  │
│   │ Humidity: 65%        │  │
│   │ Wind Speed: 12.0 m/s │  │
│   │ Precipitation: 0 mm  │  │
│   └─────────────────────┘   │
│                             │
│   ┌─ Description ────────┐  │
│   │ Partly cloudy with   │  │
│   │ light winds          │  │
│   └─────────────────────┘   │
└─────────────────────────────┘
```

**Sections**:
- Header: Icon + status + date (centered)
- Location: Card with location name
- Weather Details: Card with key-value pairs
- Description: Card with full weather description

---

### 4. Year Summary Screen

**Layout**:
```
┌─────────────────────────────┐
│   2026 Summary        📅   │
├─────────────────────────────┤
│   ┌─── Overview ─────────┐  │
│   │                      │  │
│   │  📅 45    👍 32     │  │
│   │  Total   Enjoyed    │  │
│   │          👎 13      │  │
│   │       Not Enjoyed   │  │
│   └─────────────────────┘   │
│                             │
│   ┌─ Enjoyment Rate ────┐   │
│   │        ◐ 71%        │   │ Circular
│   │      enjoyed        │   │ progress
│   └─────────────────────┘   │
│                             │
│   ┌─ Weather Patterns ──┐   │
│   │ 👍 When you enjoyed: │   │
│   │    🌡️ 22.3°C avg   │   │
│   │    ☀️ Clear         │   │
│   │                      │   │
│   │ 👎 When you didn't: │   │
│   │    🌡️ 8.5°C avg    │   │
│   │    🌧️ Rain         │   │
│   └─────────────────────┘   │
└─────────────────────────────┘
```

**Visual Elements**:
- Stat cards with icons and numbers
- Circular progress indicator (blue arc)
- Pattern cards showing correlations
- Year selector in navigation bar

---

## Interaction Patterns

### Gestures

1. **Tap**: Primary action (buttons, list items)
2. **Swipe Left**: Delete entry in history
3. **Pull to Refresh**: Reload data (implicit in SwiftUI)
4. **Scroll**: Navigate long content

### Feedback

1. **Button Press**: Visual highlight on tap
2. **Loading**: Spinning indicator with darkened background
3. **Success**: State transition (question → result)
4. **Error**: Alert dialog with OK button

### Navigation

1. **Tab Bar**: Switch between main screens
2. **Navigation**: Push/pop for detail views
3. **Modal**: Alerts for errors
4. **Dismissal**: Back button or swipe gesture

---

## Accessibility

### VoiceOver Support

All UI elements have accessibility labels:
- Buttons: "Yes button", "No button"
- Icons: "Thumbs up", "Cloud sun icon"
- Data: "Temperature: 20.5 degrees Celsius"

### Dynamic Type

Text scales with system font size settings.

### Color Contrast

All text meets WCAG AA standards:
- Primary text: Dark gray on light backgrounds
- Secondary text: Medium gray
- Buttons: High contrast colors

### Semantic Colors

Uses iOS semantic colors where appropriate:
- `.primary`, `.secondary` for text
- `.blue` for accent
- `.gray` for neutral elements

---

## Animations

### Subtle, Meaningful

1. **Loading**: Spinning progress indicator
2. **State Change**: Fade in/out of content
3. **Navigation**: Standard push/pop animations
4. **List**: Smooth scrolling and deletion
5. **Progress Ring**: Animated percentage fill

**Timing**: Fast (0.3s) to maintain responsiveness

---

## Error States

### No Location Permission

Home screen continues to work:
- Entry saved without location
- Location field shows "Location unavailable"
- No error interrupts flow

### No Weather Data

Entry still created:
- Weather fields show placeholder values
- Brief error message at bottom
- User can retry later

### Network Error

Alert dialog:
- Title: "Error"
- Message: Specific error description
- Action: "OK" button to dismiss
- Entry not saved until resolved

---

## Responsive Design

### iPhone Layouts

Works on all iPhone sizes:
- iPhone 15 Pro Max: Spacious
- iPhone SE: Compact, scrollable

### iPad Support

While optimized for iPhone:
- Runs in compatibility mode on iPad
- Larger screens show same layout scaled

---

## Dark Mode

Currently using light mode only:
- Could add dark mode support
- Would need darker gradients
- Icons remain recognizable

---

## Performance

### Smooth Scrolling

- List virtualization (SwiftUI automatic)
- Minimal re-renders
- No heavy computations in UI

### Fast Launch

- Lightweight Core Data
- No network calls on launch
- Immediate UI display

### Responsive Input

- Buttons respond instantly
- Loading indicators appear quickly
- No UI freezing

---

## Future UI Enhancements

Potential improvements:
1. **Calendar View**: Visual heatmap of days
2. **Charts**: Bar graphs for monthly trends
3. **Themes**: User-selectable color schemes
4. **Animations**: More delightful transitions
5. **Widgets**: Home screen summary
6. **Haptics**: Tactile feedback on interactions

---

For implementation details, see the SwiftUI files in `Sources/ANiceDay/Views/`.
