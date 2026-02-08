import SwiftUI

/// Home screen displaying daily weather prompt
/// Shows "Did you enjoy the weather today?" with Yes/No buttons
/// Once answered, displays today's entry
public struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    public init() {}
    
    public var body: some View {
        NavigationView {
            ZStack {
                // Calm background gradient
                LinearGradient(
                    colors: [Color.blue.opacity(0.1), Color.cyan.opacity(0.2)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 30) {
                    if viewModel.hasLoggedToday {
                        // Show today's result
                        todayResultView
                    } else {
                        // Show daily prompt
                        dailyPromptView
                    }
                }
                .padding()
                
                // Loading overlay
                if viewModel.isLoading {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.white)
                }
            }
            .navigationTitle("A Nice Day")
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
    
    // MARK: - Daily Prompt View
    
    private var dailyPromptView: some View {
        VStack(spacing: 40) {
            Spacer()
            
            // Question
            VStack(spacing: 20) {
                Image(systemName: "cloud.sun")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                
                Text("Did you enjoy the")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Text("weather today?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            // Response buttons
            HStack(spacing: 20) {
                Button {
                    Task {
                        await viewModel.submitResponse(enjoyedWeather: false)
                    }
                } label: {
                    Text("No")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(Color.gray)
                        .cornerRadius(15)
                }
                
                Button {
                    Task {
                        await viewModel.submitResponse(enjoyedWeather: true)
                    }
                } label: {
                    Text("Yes")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(Color.blue)
                        .cornerRadius(15)
                }
            }
            
            Spacer()
                .frame(height: 50)
        }
    }
    
    // MARK: - Today's Result View
    
    private var todayResultView: some View {
        VStack(spacing: 30) {
            Spacer()
            
            // Response indicator
            VStack(spacing: 20) {
                Image(systemName: viewModel.todayEntry?.enjoyedWeather == true ? "hand.thumbsup.fill" : "hand.thumbsdown.fill")
                    .font(.system(size: 80))
                    .foregroundColor(viewModel.todayEntry?.enjoyedWeather == true ? .blue : .gray)
                
                Text("You \(viewModel.todayEntry?.enjoyedWeather == true ? "enjoyed" : "did not enjoy")")
                    .font(.title2)
                    .foregroundColor(.secondary)
                
                Text("today's weather")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            
            // Entry details
            if let entry = viewModel.todayEntry {
                VStack(alignment: .leading, spacing: 15) {
                    DetailRow(icon: "calendar", title: "Date", value: formatDate(entry.date))
                    
                    if let location = entry.locationName {
                        DetailRow(icon: "location", title: "Location", value: location)
                    }
                    
                    if let condition = entry.weatherCondition {
                        DetailRow(icon: "cloud", title: "Condition", value: condition)
                    }
                    
                    DetailRow(icon: "thermometer", title: "Temperature", value: String(format: "%.1f°C", entry.temperature))
                }
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(15)
            }
            
            Spacer()
            
            Text("See you tomorrow!")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Spacer()
                .frame(height: 50)
        }
    }
    
    // MARK: - Helper Functions
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

// MARK: - Detail Row Component

struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            
            Text(title)
                .foregroundColor(.secondary)
                .frame(width: 100, alignment: .leading)
            
            Text(value)
                .fontWeight(.medium)
            
            Spacer()
        }
    }
}

// MARK: - Previews

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
