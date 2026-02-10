import SwiftUI

/// Main app entry point
/// Sets up the Core Data environment and navigation
@main
public struct ANiceDayApp: App {
    // Initialize persistence service on app launch
    @StateObject private var persistenceService = PersistenceService.shared
    
    public init() {}
    
    public var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceService.viewContext)
        }
    }
}

/// Root content view with tab navigation
struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Today", systemImage: "sun.max")
                }
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "calendar")
                }
            
            YearSummaryView()
                .tabItem {
                    Label("Summary", systemImage: "chart.bar")
                }
        }
    }
}
