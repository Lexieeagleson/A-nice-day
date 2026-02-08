import Foundation
import WeatherKit
import CoreLocation

/// Protocol defining weather service interface
/// This allows swapping implementations (e.g., from WeatherKit to another API)
public protocol WeatherServiceProtocol {
    func fetchWeather(for location: LocationData) async throws -> WeatherData
}

/// WeatherKit implementation of weather service
/// Requires WeatherKit entitlement in Xcode project
public class WeatherKitService: WeatherServiceProtocol {
    private let service = WeatherService.shared
    
    public init() {}
    
    /// Fetch current weather for given location
    public func fetchWeather(for location: LocationData) async throws -> WeatherData {
        let clLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        // Fetch current and daily forecast
        let weather = try await service.weather(for: clLocation)
        
        let current = weather.currentWeather
        let dailyForecast = weather.dailyForecast.first
        
        return WeatherData(
            temperature: current.temperature.value,
            highTemp: dailyForecast?.highTemperature.value ?? current.temperature.value,
            lowTemp: dailyForecast?.lowTemperature.value ?? current.temperature.value,
            condition: current.condition.description,
            precipitation: dailyForecast?.precipitationAmount.value ?? 0,
            humidity: current.humidity,
            windSpeed: current.wind.speed.value,
            description: current.condition.description
        )
    }
}

/// Mock weather service for development/testing when WeatherKit is unavailable
/// Returns simulated weather data
public class MockWeatherService: WeatherServiceProtocol {
    public init() {}
    
    public func fetchWeather(for location: LocationData) async throws -> WeatherData {
        // Simulate network delay
        try await Task.sleep(nanoseconds: 1_000_000_000)
        
        // Return mock data
        return WeatherData(
            temperature: 20.0,
            highTemp: 25.0,
            lowTemp: 15.0,
            condition: "Partly Cloudy",
            precipitation: 0.2,
            humidity: 0.65,
            windSpeed: 12.0,
            description: "Partly cloudy with light winds"
        )
    }
}

/// Main weather service coordinator
/// Wraps the actual service implementation and handles errors gracefully
public class WeatherService: ObservableObject {
    private let implementation: WeatherServiceProtocol
    
    @Published public var errorMessage: String?
    
    /// Initialize with specific implementation
    /// - Parameter useWeatherKit: If true, uses WeatherKit; otherwise uses mock service
    public init(useWeatherKit: Bool = true) {
        if useWeatherKit {
            self.implementation = WeatherKitService()
        } else {
            self.implementation = MockWeatherService()
        }
    }
    
    /// Fetch weather data for location
    /// Returns nil if fetch fails, with error stored in errorMessage
    public func fetchWeather(for location: LocationData?) async -> WeatherData? {
        guard let location = location else {
            errorMessage = "Location unavailable"
            return nil
        }
        
        do {
            let weather = try await implementation.fetchWeather(for: location)
            errorMessage = nil
            return weather
        } catch {
            errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
            return nil
        }
    }
}
