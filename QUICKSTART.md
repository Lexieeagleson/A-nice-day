# Quick Start Guide - A Nice Day

Get up and running with A Nice Day in 5 minutes!

## 🚀 Quick Start

### 1. Open in Xcode (30 seconds)

```bash
# Clone the repository
git clone https://github.com/Lexieeagleson/A-nice-day.git
cd A-nice-day

# Open in Xcode
open Package.swift
```

Or simply **double-click** `Package.swift` in Finder.

### 2. Select Target (10 seconds)

In Xcode's toolbar, select:
- **iPhone 15 Pro** (or any iOS 17+ simulator)
- Or connect your physical iPhone

### 3. Run (30 seconds)

Press **⌘R** or click the ▶️ button.

Wait for build to complete (~30-60 seconds first time).

### 4. Grant Permissions (30 seconds)

When the app launches:
1. Tap **"Allow While Using App"** for location
2. You're ready to log your first day!

---

## 📱 Your First Entry

1. **See the prompt**: "Did you enjoy the weather today?"
2. **Tap Yes or No**: Choose based on your actual experience
3. **Wait briefly**: App fetches location and weather (~2-3 seconds)
4. **See your entry**: Today's result is displayed

That's it! ✅

---

## 🔄 Daily Workflow

Each day:
1. Open the app
2. Answer the single question
3. View your response + weather details
4. Come back tomorrow!

---

## 📊 Exploring Features

### History Tab
- Tap **"History"** at the bottom
- See all your past entries
- Tap any entry for full details
- Swipe left to delete

### Summary Tab
- Tap **"Summary"** at the bottom
- View your enjoyment percentage
- See weather patterns
- Change years using calendar icon

---

## ⚙️ Using Real Weather (Optional)

By default, the app uses **mock weather data** for easy testing.

To use **real WeatherKit**:

1. **Add WeatherKit capability**:
   - Select project in navigator
   - Go to "Signing & Capabilities"
   - Click "+ Capability"
   - Add "WeatherKit"

2. **Update code** in `HomeViewModel.swift` line 20:
   ```swift
   weatherService: WeatherService(useWeatherKit: true)
   ```

3. **Rebuild** (⌘R)

Note: Requires Apple Developer account and proper entitlements.

---

## 🐛 Troubleshooting

### App won't build
- Make sure you're using Xcode 15+
- Select an iOS 17+ simulator
- Try Product → Clean Build Folder (⌘⇧K)

### Location not working
- Check Settings → Privacy → Location Services
- Enable location for the app
- Restart the app

### Can't log entry
- You can only log once per day
- Check if you already logged today
- Try again tomorrow!

---

## 📚 Learn More

- **Full documentation**: See [README.md](README.md)
- **Setup guide**: See [SETUP.md](SETUP.md)
- **Architecture**: See [ARCHITECTURE.md](ARCHITECTURE.md)

---

## 💡 Tips

1. **Test without location**: Deny location permission to see graceful handling
2. **View patterns**: Log for a few days and check the Summary tab
3. **Explore code**: All code is well-documented with inline comments
4. **Customize UI**: Modify colors and layout in `Views/` folder

---

## ⏱️ Time Spent: ~5 minutes

- Opening: 30s
- Selecting target: 10s
- First build: 60s
- Granting permission: 30s
- First entry: 30s
- Exploring: 2 minutes

**Total**: ~5 minutes from clone to first entry! 🎉

---

## Next Steps

1. ✅ Complete your first entry
2. ✅ Explore all three tabs
3. ✅ Read the architecture docs
4. ✅ Customize the UI to your taste
5. ✅ Share feedback!

Happy weather logging! 🌤️
