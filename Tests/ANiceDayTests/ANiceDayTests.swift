import XCTest
@testable import ANiceDay

/// Unit tests for A Nice Day app
/// These tests verify core functionality of models and services
final class ANiceDayTests: XCTestCase {
    
    func testWeatherDataCreation() {
        let weather = WeatherData(
            temperature: 20.0,
            highTemp: 25.0,
            lowTemp: 15.0,
            condition: "Clear",
            precipitation: 0.0,
            humidity: 0.6,
            windSpeed: 10.0,
            description: "Clear skies"
        )
        
        XCTAssertEqual(weather.temperature, 20.0)
        XCTAssertEqual(weather.condition, "Clear")
    }
    
    func testLocationDataCreation() {
        let location = LocationData(
            name: "San Francisco, CA, USA",
            latitude: 37.7749,
            longitude: -122.4194
        )
        
        XCTAssertEqual(location.name, "San Francisco, CA, USA")
        XCTAssertEqual(location.latitude, 37.7749, accuracy: 0.0001)
    }
    
    func testMockWeatherService() async throws {
        let service = MockWeatherService()
        let location = LocationData(name: "Test City", latitude: 0, longitude: 0)
        
        let weather = try await service.fetchWeather(for: location)
        
        XCTAssertNotNil(weather)
        XCTAssertEqual(weather.condition, "Partly Cloudy")
    }
}
