# Visual Guide & Screenshots

This guide describes what you'll see when running the "A Nice Day" app.

## 📱 App Icon Concept

While no custom icon is included, the app uses:
- **Name**: "A Nice Day" (or "ANiceDay" in code)
- **Suggested Icon**: Cloud with sun (☀️☁️) on blue background
- **Color Scheme**: Soft blues and cyans

## 🏠 Screen 1: Home View - Before Logging

### What You'll See

```
┌─────────────────────────────────────┐
│ ←    A Nice Day                    │
├─────────────────────────────────────┤
│                                     │
│         Light blue gradient         │
│         background                  │
│                                     │
│           ☀️☁️                     │
│         (Large icon)                │
│                                     │
│      Did you enjoy the             │
│      weather today?                │
│      (Large, centered text)        │
│                                     │
│                                     │
│   ┌──────────┐    ┌──────────┐    │
│   │          │    │          │    │
│   │   No     │    │   Yes    │    │
│   │  (Gray)  │    │  (Blue)  │    │
│   │          │    │          │    │
│   └──────────┘    └──────────┘    │
│                                     │
│                                     │
└─────────────────────────────────────┘
  Today    History    Summary
    ●          ○          ○
```

### Details
- **Background**: Smooth gradient from light blue (top) to cyan (bottom)
- **Icon**: SF Symbol "cloud.sun" in blue, size 80pt
- **Question**: Two lines, large title font, centered
- **Buttons**: 
  - "No": Gray (#808080), rounded corners
  - "Yes": Blue (#007AFF), rounded corners
  - Both equal width, side by side
- **Tab Bar**: Three tabs at bottom (Today, History, Summary)

### Interaction
1. Tap "Yes" or "No"
2. Screen shows loading spinner
3. Background darkens slightly
4. After 2-3 seconds, transitions to logged state

---

## 🏠 Screen 2: Home View - After Logging

### What You'll See

```
┌─────────────────────────────────────┐
│ ←    A Nice Day                    │
├─────────────────────────────────────┤
│                                     │
│                                     │
│           👍                        │
│      (Large thumbs up)              │
│                                     │
│      You enjoyed                    │
│      today's weather                │
│                                     │
│   ┌─────────────────────────────┐  │
│   │ 📅 Jan 15, 2026 3:45 PM   │  │
│   │ 📍 San Francisco, CA, USA  │  │
│   │ ☁️  Partly Cloudy          │  │
│   │ 🌡️  20.5°C                │  │
│   └─────────────────────────────┘  │
│                                     │
│      See you tomorrow!             │
│                                     │
└─────────────────────────────────────┘
  Today    History    Summary
    ●          ○          ○
```

### Details
- **Icon**: Thumbs up (👍) if enjoyed, thumbs down (👎) if not
- **Color**: Blue for enjoyed, gray for not enjoyed
- **Info Card**: 
  - White background with 80% opacity
  - Rounded corners (15pt radius)
  - SF Symbol icons in blue
  - Left-aligned text
- **Message**: Friendly "See you tomorrow!" at bottom

### If Location Denied
The card would show:
```
┌─────────────────────────────────┐
│ 📅 Jan 15, 2026 3:45 PM       │
│ 📍 Location unavailable        │
│ ☁️  Partly Cloudy              │
│ 🌡️  20.5°C                    │
└─────────────────────────────────┘
```

---

## 📚 Screen 3: History View - Empty

### What You'll See

```
┌─────────────────────────────────────┐
│ ←    History                       │
├─────────────────────────────────────┤
│                                     │
│         Light blue/cyan             │
│         gradient background         │
│                                     │
│                                     │
│           📅❗                      │
│      (Calendar with alert)          │
│                                     │
│      No entries yet                │
│                                     │
│   Start logging your weather       │
│   experiences!                      │
│                                     │
│                                     │
└─────────────────────────────────────┘
  Today    History    Summary
    ○          ●          ○
```

---

## 📚 Screen 4: History View - With Entries

### What You'll See

```
┌─────────────────────────────────────┐
│ ←    History                       │
├─────────────────────────────────────┤
│ ┌─────────────────────────────────┐ │
│ │ 👍  January 15, 2026          ▶ │ │
│ │     San Francisco, CA, USA      │ │
│ │     ☁️ Partly Cloudy · 20.5°C  │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ 👎  January 14, 2026          ▶ │ │
│ │     Oakland, CA, USA            │ │
│ │     🌧️ Rainy · 12.0°C          │ │
│ └─────────────────────────────────┘ │
│                                     │
│ ┌─────────────────────────────────┐ │
│ │ 👍  January 13, 2026          ▶ │ │
│ │     Berkeley, CA, USA           │ │
│ │     ☀️ Clear · 22.0°C           │ │
│ └─────────────────────────────────┘ │
│                                     │
└─────────────────────────────────────┘
  Today    History    Summary
    ○          ●          ○
```

### Details
- **Entry Cards**: 
  - White background with 60% opacity
  - Rounded corners (12pt radius)
  - Padding around content
  - Shadow for depth
- **Layout**:
  - Large thumbs up/down icon on left (40pt width)
  - Date in bold headline font
  - Location in secondary gray
  - Weather row with icon, condition, and temperature
- **Interaction**:
  - Tap entry → navigates to detail view
  - Swipe left → reveals red "Delete" button
  - Scrollable list

---

## 🔍 Screen 5: Entry Detail View

### What You'll See

```
┌─────────────────────────────────────┐
│ ← Back                              │
├─────────────────────────────────────┤
│                                     │
│           👍                        │
│      (Large icon)                   │
│                                     │
│        Enjoyed                      │
│   January 15, 2026 3:45 PM         │
│                                     │
│   ┌── Location ──────────────────┐ │
│   │ 📍 San Francisco, CA, USA   │ │
│   └─────────────────────────────┘  │
│                                     │
│   ┌── Weather Details ───────────┐ │
│   │ Condition:     Partly Cloudy│ │
│   │ Temperature:   20.5°C       │ │
│   │ High / Low:    25.0 / 15.0  │ │
│   │ Humidity:      65%          │ │
│   │ Wind Speed:    12.0 m/s     │ │
│   │ Precipitation: 0.0 mm       │ │
│   └─────────────────────────────┘  │
│                                     │
│   ┌── Description ──────────────┐  │
│   │ Partly cloudy with light    │ │
│   │ winds                       │ │
│   └─────────────────────────────┘  │
│                                     │
└─────────────────────────────────────┘
```

### Details
- **Header**: Icon, status, and timestamp centered
- **Sections**: Cards with title and content
- **Info Rows**: Label on left, value on right
- **Scrollable**: Long content can be scrolled
- **Navigation**: Back button returns to history

---

## 📊 Screen 6: Year Summary - Empty

### What You'll See

```
┌─────────────────────────────────────┐
│ ←    2026 Summary           📅    │
├─────────────────────────────────────┤
│                                     │
│                                     │
│                                     │
│           📊                        │
│      (Bar chart icon)               │
│                                     │
│      No data for 2026              │
│                                     │
│   Start logging to see your        │
│   yearly summary                    │
│                                     │
│                                     │
│                                     │
└─────────────────────────────────────┘
  Today    History    Summary
    ○          ○          ●
```

---

## 📊 Screen 7: Year Summary - With Data

### What You'll See

```
┌─────────────────────────────────────┐
│ ←    2026 Summary           📅    │
├─────────────────────────────────────┤
│   ┌────── Overview ──────────────┐ │
│   │                              │ │
│   │  📅 45    👍 32    👎 13   │ │
│   │  Total   Enjoyed  Not      │ │
│   │                              │ │
│   └──────────────────────────────┘ │
│                                     │
│   ┌── Enjoyment Rate ────────────┐ │
│   │                              │ │
│   │          ◐                   │ │
│   │        71%                   │ │
│   │      enjoyed                 │ │
│   │   (Circular progress)        │ │
│   └──────────────────────────────┘ │
│                                     │
│   ┌── Weather Patterns ─────────┐ │
│   │ 👍 When you enjoyed:         │ │
│   │    🌡️ 22.3°C avg            │ │
│   │    ☀️ Clear                 │ │
│   │                              │ │
│   │ 👎 When you didn't:          │ │
│   │    🌡️ 8.5°C avg             │ │
│   │    🌧️ Rain                  │ │
│   └──────────────────────────────┘ │
└─────────────────────────────────────┘
  Today    History    Summary
    ○          ○          ●
```

### Details
- **Stat Cards**:
  - Three columns showing totals
  - Icons and large numbers
  - Labels below
- **Progress Circle**:
  - 150pt diameter
  - Blue arc showing percentage
  - Gray background circle
  - Number and label centered
- **Pattern Cards**:
  - Temperature averages
  - Most common conditions
  - Color-coded icons
- **Year Selector**:
  - Tap calendar icon in nav bar
  - Menu shows last 5 years
  - Select to change year

---

## 🎨 Color Palette

### Primary Colors
- **Blue**: #007AFF (enjoyed, accents)
- **Gray**: #808080 (not enjoyed, secondary)
- **White**: #FFFFFF (cards, text)
- **Black**: #000000 (primary text)

### Gradients
- **Background**: 
  - Top: Blue at 10% opacity
  - Bottom: Cyan at 20% opacity
- **Loading**: Black at 30% opacity

### SF Symbols Used
- `cloud.sun` - Home icon before logging
- `hand.thumbsup.fill` - Enjoyed indicator
- `hand.thumbsdown.fill` - Not enjoyed indicator
- `calendar` - Date icon
- `location` / `location.fill` - Location icon
- `cloud` - Weather condition
- `thermometer` - Temperature
- `sun.max` - Clear/sunny weather
- `cloud.rain` - Rainy weather
- `snow` - Snowy weather
- `calendar.badge.exclamationmark` - Empty history
- `chart.bar` - Empty summary

---

## 💫 Animations

### Loading State
- Spinning progress indicator (white)
- Darkened background overlay
- Appears immediately on button tap
- Dismisses when data loaded

### Navigation
- Push/pop with slide animation (standard iOS)
- Fade transitions for state changes
- Smooth list scrolling

### Circular Progress
- Animated stroke from 0% to final percentage
- 0.3 second duration
- Ease-in-out timing

---

## 📐 Layout Specifications

### Spacing
- **Padding**: 20-30pt around screens
- **Section Spacing**: 20-25pt between cards
- **Card Padding**: 15-20pt inside cards
- **Button Height**: 60pt (including padding)

### Typography
- **Large Title**: 34pt (question, results)
- **Title**: 28pt (section headers)
- **Title 2**: 22pt (button text)
- **Headline**: 17pt bold (entry dates)
- **Body**: 17pt (descriptions)
- **Subheadline**: 15pt (locations)
- **Caption**: 12pt (labels, secondary info)

### Corners
- **Buttons**: 15pt radius
- **Large Cards**: 20pt radius
- **Small Cards**: 12-15pt radius

---

## 🌓 Dark Mode (Future)

Currently light mode only. For dark mode:
- Invert gradients (darker blues)
- White cards → dark gray cards
- Dark text → light text
- Keep blue accents consistent

---

## ♿ Accessibility

### VoiceOver Labels
- All buttons clearly labeled
- Icons have descriptions
- Data reads in logical order

### Dynamic Type
- All text scales with system settings
- Layout adjusts for larger text

### Color Contrast
- All text meets WCAG AA standards
- Blue on white: 4.5:1+ ratio
- Gray on white: 4.5:1+ ratio

---

## 📱 Device Support

### iPhone Sizes
- **Optimized for**: iPhone 13/14/15 Pro (6.1")
- **Works on**: All iPhone sizes with iOS 17+
- **Adapts to**: SE (small), Pro Max (large)

### iPad
- Runs in iPhone compatibility mode
- Could be optimized for larger screens

---

## 🎬 User Flow Summary

1. **Launch** → Home screen with question
2. **Tap Yes/No** → Loading spinner
3. **Data fetched** → Shows today's result
4. **Next day** → Question appears again
5. **Tap History** → See all entries
6. **Tap entry** → View full details
7. **Tap Summary** → See statistics
8. **Select year** → Change year view

---

For actual screenshots, run the app in Xcode and use:
- **Simulator**: Cmd+S to take screenshot
- **Device**: Volume Up + Power button

Screenshots will be saved to Desktop for documentation.
