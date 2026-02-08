import SwiftUI

/// Year summary view showing statistics and patterns
/// Displays total Yes/No count and weather correlations
public struct YearSummaryView: View {
    @StateObject private var viewModel = YearSummaryViewModel()
    
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
                
                if viewModel.totalDays == 0 {
                    emptyStateView
                } else {
                    summaryContentView
                }
            }
            .navigationTitle("\(viewModel.selectedYear) Summary")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        ForEach(availableYears, id: \.self) { year in
                            Button("\(year)") {
                                viewModel.changeYear(to: year)
                            }
                        }
                    } label: {
                        Image(systemName: "calendar")
                    }
                }
            }
        }
    }
    
    // MARK: - Empty State
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "chart.bar")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("No data for \(viewModel.selectedYear)")
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("Start logging to see your yearly summary")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
    
    // MARK: - Summary Content
    
    private var summaryContentView: some View {
        ScrollView {
            VStack(spacing: 25) {
                // Overview card
                VStack(spacing: 20) {
                    Text("Overview")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 30) {
                        StatCard(
                            icon: "calendar",
                            value: "\(viewModel.totalDays)",
                            label: "Total Days"
                        )
                        
                        StatCard(
                            icon: "hand.thumbsup.fill",
                            value: "\(viewModel.enjoyedDays)",
                            label: "Enjoyed",
                            color: .blue
                        )
                        
                        StatCard(
                            icon: "hand.thumbsdown.fill",
                            value: "\(viewModel.notEnjoyedDays)",
                            label: "Not Enjoyed",
                            color: .gray
                        )
                    }
                }
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(20)
                
                // Percentage card
                VStack(spacing: 15) {
                    Text("Enjoyment Rate")
                        .font(.headline)
                    
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.3), lineWidth: 15)
                            .frame(width: 150, height: 150)
                        
                        Circle()
                            .trim(from: 0, to: viewModel.enjoymentPercentage / 100)
                            .stroke(
                                Color.blue,
                                style: StrokeStyle(lineWidth: 15, lineCap: .round)
                            )
                            .frame(width: 150, height: 150)
                            .rotationEffect(.degrees(-90))
                            .animation(.easeInOut, value: viewModel.enjoymentPercentage)
                        
                        VStack {
                            Text(String(format: "%.0f%%", viewModel.enjoymentPercentage))
                                .font(.system(size: 36, weight: .bold))
                            Text("enjoyed")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(20)
                
                // Weather patterns card
                VStack(alignment: .leading, spacing: 15) {
                    Text("Weather Patterns")
                        .font(.headline)
                    
                    VStack(spacing: 12) {
                        if viewModel.enjoyedDays > 0 {
                            PatternRow(
                                icon: "hand.thumbsup.fill",
                                color: .blue,
                                title: "When you enjoyed:",
                                avgTemp: viewModel.averageTempOnEnjoyedDays,
                                condition: viewModel.mostCommonEnjoyedCondition
                            )
                        }
                        
                        if viewModel.notEnjoyedDays > 0 {
                            Divider()
                            
                            PatternRow(
                                icon: "hand.thumbsdown.fill",
                                color: .gray,
                                title: "When you didn't:",
                                avgTemp: viewModel.averageTempOnNotEnjoyedDays,
                                condition: viewModel.mostCommonNotEnjoyedCondition
                            )
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.8))
                .cornerRadius(20)
                
                Spacer()
            }
            .padding()
        }
    }
    
    // MARK: - Helper Properties
    
    /// Number of past years to show in year selector
    private let yearsToShow = 5
    
    private var availableYears: [Int] {
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array((currentYear - yearsToShow)...currentYear).reversed()
    }
}

// MARK: - Stat Card Component

struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    var color: Color = .primary
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Pattern Row Component

struct PatternRow: View {
    let icon: String
    let color: Color
    let title: String
    let avgTemp: Double
    let condition: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            
            HStack(spacing: 15) {
                Label(String(format: "%.1f°C avg", avgTemp), systemImage: "thermometer")
                    .font(.caption)
                
                if let condition = condition {
                    Label(condition, systemImage: "cloud")
                        .font(.caption)
                }
            }
            .foregroundColor(.secondary)
        }
    }
}

// MARK: - Previews

struct YearSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        YearSummaryView()
    }
}
