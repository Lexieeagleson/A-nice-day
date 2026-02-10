import SwiftUI

/// Detail view for a single weather entry
/// Shows complete information about a logged day
public struct EntryDetailView: View {
    let entry: WeatherEntry
    
    public init(entry: WeatherEntry) {
        self.entry = entry
    }
    
    public var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                colors: [Color.blue.opacity(0.1), Color.cyan.opacity(0.2)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Header
                    VStack(spacing: 15) {
                        Image(systemName: entry.enjoyedWeather ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                            .font(.system(size: 60))
                            .foregroundColor(entry.enjoyedWeather ? .blue : .gray)
                        
                        Text(entry.enjoyedWeather ? "Enjoyed" : "Did Not Enjoy")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(formatDate(entry.date))
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    
                    // Location section
                    if let location = entry.locationName {
                        SectionCard(title: "Location") {
                            HStack {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.blue)
                                Text(location)
                                    .font(.body)
                                Spacer()
                            }
                        }
                    }
                    
                    // Weather section
                    SectionCard(title: "Weather Details") {
                        VStack(spacing: 12) {
                            if let condition = entry.weatherCondition {
                                InfoRow(label: "Condition", value: condition)
                            }
                            
                            InfoRow(label: "Temperature", value: String(format: "%.1f°C", entry.temperature))
                            InfoRow(label: "High / Low", value: String(format: "%.1f°C / %.1f°C", entry.highTemp, entry.lowTemp))
                            InfoRow(label: "Humidity", value: String(format: "%.0f%%", entry.humidity * 100))
                            InfoRow(label: "Wind Speed", value: String(format: "%.1f m/s", entry.windSpeed))
                            
                            if entry.precipitation > 0 {
                                InfoRow(label: "Precipitation", value: String(format: "%.1f mm", entry.precipitation))
                            }
                        }
                    }
                    
                    // Description section
                    if let description = entry.weatherDescription {
                        SectionCard(title: "Description") {
                            Text(description)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// MARK: - Section Card Component

struct SectionCard<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(15)
    }
}

// MARK: - Info Row Component

struct InfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}
