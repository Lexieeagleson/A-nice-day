import SwiftUI

/// History view showing all past entries
/// Displays entries in a list with visual distinction between Yes and No
public struct HistoryView: View {
    @StateObject private var viewModel = HistoryViewModel()
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color.blue.opacity(0.05), Color.cyan.opacity(0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                if viewModel.entries.isEmpty {
                    emptyStateView
                } else {
                    entriesListView
                }
            }
            .navigationTitle("History")
            .onAppear {
                viewModel.loadEntries()
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") {
                    viewModel.errorMessage = nil
                }
            } message: {
                if let error = viewModel.errorMessage {
                    Text(error)
                }
            }
        }
    }
    
    // MARK: - Empty State
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No entries yet")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("Start logging your weather experiences!")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
    
    // MARK: - Entries List
    
    private var entriesListView: some View {
        List {
            ForEach(viewModel.entries) { entry in
                NavigationLink(destination: EntryDetailView(entry: entry)) {
                    EntryRow(entry: entry)
                }
                .listRowBackground(Color.clear)
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    viewModel.deleteEntry(viewModel.entries[index])
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
}

// MARK: - Entry Row Component

struct EntryRow: View {
    let entry: WeatherEntry
    
    var body: some View {
        HStack(spacing: 15) {
            // Response indicator
            Image(systemName: entry.enjoyedWeather ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                .font(.title2)
                .foregroundColor(entry.enjoyedWeather ? .blue : .gray)
                .frame(width: 40)
            
            // Entry details
            VStack(alignment: .leading, spacing: 5) {
                Text(formatDate(entry.date))
                    .font(.headline)
                
                if let location = entry.locationName {
                    Text(location)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                if let condition = entry.weatherCondition {
                    HStack {
                        Image(systemName: weatherIcon(for: condition))
                            .foregroundColor(.blue)
                        Text(condition)
                            .font(.subheadline)
                        Text("•")
                            .foregroundColor(.secondary)
                        Text(String(format: "%.1f°C", entry.temperature))
                            .font(.subheadline)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.6))
        .cornerRadius(12)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    private func weatherIcon(for condition: String) -> String {
        let lowercased = condition.lowercased()
        if lowercased.contains("clear") || lowercased.contains("sunny") {
            return "sun.max"
        } else if lowercased.contains("cloud") {
            return "cloud"
        } else if lowercased.contains("rain") {
            return "cloud.rain"
        } else if lowercased.contains("snow") {
            return "snow"
        } else {
            return "cloud.sun"
        }
    }
}

// MARK: - Previews

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
