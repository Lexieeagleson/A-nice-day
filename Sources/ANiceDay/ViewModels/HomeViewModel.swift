import Foundation
import SwiftUI
import Combine

/// ViewModel for the home screen
/// Manages daily prompt, user response, and today's entry state
@MainActor
public class HomeViewModel: ObservableObject {
    @Published public var todayEntry: WeatherEntry?
    @Published public var isLoading = false
    @Published public var errorMessage: String?
    
    private let persistenceService: PersistenceService
    private let locationService: LocationService
    private let weatherService: WeatherService
    
    public init(
        persistenceService: PersistenceService = .shared,
        locationService: LocationService = LocationService(),
        weatherService: WeatherService = WeatherService(useWeatherKit: false) // Use mock for now
    ) {
        self.persistenceService = persistenceService
        self.locationService = locationService
        self.weatherService = weatherService
        
        loadTodayEntry()
    }
    
    /// Check if user has already logged for today
    public var hasLoggedToday: Bool {
        todayEntry != nil
    }
    
    /// Load today's entry if it exists
    public func loadTodayEntry() {
        todayEntry = persistenceService.fetchTodayEntry()
    }
    
    /// Handle user's response (Yes or No)
    /// Fetches location and weather, then creates entry
    public func submitResponse(enjoyedWeather: Bool) async {
        isLoading = true
        errorMessage = nil
        
        // Fetch location
        let location: LocationData?
        do {
            location = try await locationService.fetchLocation()
        } catch {
            // Continue even if location fails
            location = nil
        }
        
        // Fetch weather
        let weather = await weatherService.fetchWeather(for: location)
        
        // Create entry
        do {
            let entry = try persistenceService.createEntry(
                enjoyedWeather: enjoyedWeather,
                location: location,
                weather: weather
            )
            todayEntry = entry
        } catch {
            errorMessage = "Failed to save entry: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    /// Request location permission
    public func requestLocationPermission() {
        locationService.requestPermission()
    }
}
