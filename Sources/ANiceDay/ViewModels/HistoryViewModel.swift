import Foundation
import SwiftUI
import CoreData

/// ViewModel for the history screen
/// Displays all past entries with filtering and sorting
@MainActor
public class HistoryViewModel: ObservableObject {
    @Published public var entries: [WeatherEntry] = []
    
    private let persistenceService: PersistenceService
    
    public init(persistenceService: PersistenceService = .shared) {
        self.persistenceService = persistenceService
        loadEntries()
    }
    
    /// Load all entries from persistence
    public func loadEntries() {
        entries = persistenceService.fetchAllEntries()
    }
    
    /// Delete an entry
    public func deleteEntry(_ entry: WeatherEntry) {
        do {
            try persistenceService.delete(entry)
            loadEntries()
        } catch {
            print("Failed to delete entry: \(error)")
        }
    }
    
    /// Get entries grouped by year
    public var entriesByYear: [Int: [WeatherEntry]] {
        Dictionary(grouping: entries) { entry in
            Calendar.current.component(.year, from: entry.date)
        }
    }
}
