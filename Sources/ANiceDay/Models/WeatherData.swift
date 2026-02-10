import Foundation

/// Represents weather data fetched from WeatherKit or other service
/// This is a lightweight struct used for passing weather info before persisting
public struct WeatherData: Codable, Equatable {
    public let temperature: Double // Current temperature in Celsius
    public let highTemp: Double
    public let lowTemp: Double
    public let condition: String // e.g., "Clear", "Cloudy", "Rain"
    public let precipitation: Double // mm or probability
    public let humidity: Double // percentage
    public let windSpeed: Double // km/h or m/s
    public let description: String // Human-readable description
    
    public init(
        temperature: Double,
        highTemp: Double,
        lowTemp: Double,
        condition: String,
        precipitation: Double,
        humidity: Double,
        windSpeed: Double,
        description: String
    ) {
        self.temperature = temperature
        self.highTemp = highTemp
        self.lowTemp = lowTemp
        self.condition = condition
        self.precipitation = precipitation
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.description = description
    }
}

/// Represents a location with human-readable name
public struct LocationData: Equatable {
    public let name: String // e.g., "San Francisco, CA, USA"
    public let latitude: Double
    public let longitude: Double
    
    public init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
}
