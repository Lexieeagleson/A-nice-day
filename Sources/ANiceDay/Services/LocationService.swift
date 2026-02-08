import Foundation
import CoreLocation
import Combine

/// Service for managing location permissions and fetching user's location
/// Uses CoreLocation to get coordinates and reverse geocoding for human-readable names
public class LocationService: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published public var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published public var currentLocation: LocationData?
    @Published public var errorMessage: String?
    
    private var locationContinuation: CheckedContinuation<LocationData?, Error>?
    
    public override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        authorizationStatus = locationManager.authorizationStatus
    }
    
    /// Request location permission from user
    /// The Info.plist must include NSLocationWhenInUseUsageDescription
    public func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    /// Fetch current location with human-readable name
    /// Returns nil if permission denied or location unavailable
    public func fetchLocation() async throws -> LocationData? {
        // Check authorization status
        guard authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways else {
            if authorizationStatus == .notDetermined {
                requestPermission()
            }
            return nil
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            self.locationContinuation = continuation
            locationManager.requestLocation()
        }
    }
    
    /// Convert CLLocation to LocationData with human-readable address
    private func reverseGeocode(_ location: CLLocation) async throws -> LocationData {
        let geocoder = CLGeocoder()
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        
        guard let placemark = placemarks.first else {
            throw LocationError.geocodingFailed
        }
        
        // Build human-readable location string
        var components: [String] = []
        if let city = placemark.locality {
            components.append(city)
        }
        if let state = placemark.administrativeArea {
            components.append(state)
        }
        if let country = placemark.country {
            components.append(country)
        }
        
        let name = components.isEmpty ? "Unknown Location" : components.joined(separator: ", ")
        
        return LocationData(
            name: name,
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            locationContinuation?.resume(returning: nil)
            locationContinuation = nil
            return
        }
        
        Task {
            do {
                let locationData = try await reverseGeocode(location)
                currentLocation = locationData
                locationContinuation?.resume(returning: locationData)
            } catch {
                errorMessage = error.localizedDescription
                locationContinuation?.resume(throwing: error)
            }
            locationContinuation = nil
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = error.localizedDescription
        locationContinuation?.resume(throwing: error)
        locationContinuation = nil
    }
}

// MARK: - LocationError
public enum LocationError: LocalizedError {
    case permissionDenied
    case geocodingFailed
    case locationUnavailable
    
    public var errorDescription: String? {
        switch self {
        case .permissionDenied:
            return "Location permission was denied"
        case .geocodingFailed:
            return "Failed to get location name"
        case .locationUnavailable:
            return "Location is currently unavailable"
        }
    }
}
