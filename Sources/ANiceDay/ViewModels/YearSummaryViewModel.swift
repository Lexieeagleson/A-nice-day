import Foundation
import SwiftUI

/// ViewModel for year summary statistics
/// Calculates Yes vs No patterns and weather correlations
@MainActor
public class YearSummaryViewModel: ObservableObject {
    @Published public var entries: [WeatherEntry] = []
    @Published public var selectedYear: Int
    
    private let persistenceService: PersistenceService
    
    public init(year: Int? = nil, persistenceService: PersistenceService = .shared) {
        self.persistenceService = persistenceService
        self.selectedYear = year ?? Calendar.current.component(.year, from: Date())
        loadEntries()
    }
    
    /// Load entries for selected year
    public func loadEntries() {
        let allEntries = persistenceService.fetchAllEntries()
        entries = allEntries.filter { entry in
            Calendar.current.component(.year, from: entry.date) == selectedYear
        }
    }
    
    /// Total number of days logged
    public var totalDays: Int {
        entries.count
    }
    
    /// Number of "Yes" days (enjoyed weather)
    public var enjoyedDays: Int {
        entries.filter { $0.enjoyedWeather }.count
    }
    
    /// Number of "No" days (did not enjoy weather)
    public var notEnjoyedDays: Int {
        entries.filter { !$0.enjoyedWeather }.count
    }
    
    /// Percentage of days enjoyed
    public var enjoymentPercentage: Double {
        guard totalDays > 0 else { return 0 }
        return Double(enjoyedDays) / Double(totalDays) * 100
    }
    
    /// Average temperature on enjoyed days
    public var averageTempOnEnjoyedDays: Double {
        let enjoyedEntries = entries.filter { $0.enjoyedWeather }
        guard !enjoyedEntries.isEmpty else { return 0 }
        let sum = enjoyedEntries.reduce(0.0) { $0 + $1.temperature }
        return sum / Double(enjoyedEntries.count)
    }
    
    /// Average temperature on not enjoyed days
    public var averageTempOnNotEnjoyedDays: Double {
        let notEnjoyedEntries = entries.filter { !$0.enjoyedWeather }
        guard !notEnjoyedEntries.isEmpty else { return 0 }
        let sum = notEnjoyedEntries.reduce(0.0) { $0 + $1.temperature }
        return sum / Double(notEnjoyedEntries.count)
    }
    
    /// Most common weather condition on enjoyed days
    public var mostCommonEnjoyedCondition: String? {
        let enjoyedEntries = entries.filter { $0.enjoyedWeather }
        let conditions = enjoyedEntries.compactMap { $0.weatherCondition }
        return mostFrequent(in: conditions)
    }
    
    /// Most common weather condition on not enjoyed days
    public var mostCommonNotEnjoyedCondition: String? {
        let notEnjoyedEntries = entries.filter { !$0.enjoyedWeather }
        let conditions = notEnjoyedEntries.compactMap { $0.weatherCondition }
        return mostFrequent(in: conditions)
    }
    
    /// Helper to find most frequent element in array
    private func mostFrequent(in array: [String]) -> String? {
        guard !array.isEmpty else { return nil }
        let counts = array.reduce(into: [:]) { counts, condition in
            counts[condition, default: 0] += 1
        }
        return counts.max(by: { $0.value < $1.value })?.key
    }
    
    /// Change the selected year
    public func changeYear(to year: Int) {
        selectedYear = year
        loadEntries()
    }
}
