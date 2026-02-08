import Foundation
import SwiftUI
import CoreData

/// ViewModel for the history screen
/// Displays all past entries with filtering and sorting
@MainActor
public class HistoryViewModel: ObservableObject {
    @Published public var entries: [WeatherEntry] = []
    @Published public var errorMessage: String?
    
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
            errorMessage = nil
        } catch {
            errorMessage = "Failed to delete entry: \(error.localizedDescription)"
        }
    }
    
    /// Get entries grouped by year
    public var entriesByYear: [Int: [WeatherEntry]] {
        Dictionary(grouping: entries) { entry in
            Calendar.current.component(.year, from: entry.date)
        }
    }
}
