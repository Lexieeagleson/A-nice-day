import Foundation
import CoreData

/// Manages Core Data persistence for weather entries
/// Provides a single shared instance and methods for CRUD operations
public class PersistenceService: ObservableObject {
    public static let shared = PersistenceService()
    
    /// The Core Data persistent container
    public let container: NSPersistentContainer
    
    /// Main view context for UI operations
    public var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    private init() {
        // Create the model programmatically
        let model = Self.createModel()
        container = NSPersistentContainer(name: "ANiceDay", managedObjectModel: model)
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    /// Creates the Core Data model programmatically
    private static func createModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()
        
        // Create WeatherEntry entity
        let entity = NSEntityDescription()
        entity.name = "WeatherEntry"
        entity.managedObjectClassName = "WeatherEntry"
        
        // Define attributes
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .UUIDAttributeType
        idAttribute.isOptional = false
        
        let dateAttribute = NSAttributeDescription()
        dateAttribute.name = "date"
        dateAttribute.attributeType = .dateAttributeType
        dateAttribute.isOptional = false
        
        let enjoyedWeatherAttribute = NSAttributeDescription()
        enjoyedWeatherAttribute.name = "enjoyedWeather"
        enjoyedWeatherAttribute.attributeType = .booleanAttributeType
        enjoyedWeatherAttribute.isOptional = false
        
        let locationNameAttribute = NSAttributeDescription()
        locationNameAttribute.name = "locationName"
        locationNameAttribute.attributeType = .stringAttributeType
        locationNameAttribute.isOptional = true
        
        let temperatureAttribute = NSAttributeDescription()
        temperatureAttribute.name = "temperature"
        temperatureAttribute.attributeType = .doubleAttributeType
        temperatureAttribute.isOptional = false
        
        let highTempAttribute = NSAttributeDescription()
        highTempAttribute.name = "highTemp"
        highTempAttribute.attributeType = .doubleAttributeType
        highTempAttribute.isOptional = false
        
        let lowTempAttribute = NSAttributeDescription()
        lowTempAttribute.name = "lowTemp"
        lowTempAttribute.attributeType = .doubleAttributeType
        lowTempAttribute.isOptional = false
        
        let weatherConditionAttribute = NSAttributeDescription()
        weatherConditionAttribute.name = "weatherCondition"
        weatherConditionAttribute.attributeType = .stringAttributeType
        weatherConditionAttribute.isOptional = true
        
        let precipitationAttribute = NSAttributeDescription()
        precipitationAttribute.name = "precipitation"
        precipitationAttribute.attributeType = .doubleAttributeType
        precipitationAttribute.isOptional = false
        
        let humidityAttribute = NSAttributeDescription()
        humidityAttribute.name = "humidity"
        humidityAttribute.attributeType = .doubleAttributeType
        humidityAttribute.isOptional = false
        
        let windSpeedAttribute = NSAttributeDescription()
        windSpeedAttribute.name = "windSpeed"
        windSpeedAttribute.attributeType = .doubleAttributeType
        windSpeedAttribute.isOptional = false
        
        let weatherDescriptionAttribute = NSAttributeDescription()
        weatherDescriptionAttribute.name = "weatherDescription"
        weatherDescriptionAttribute.attributeType = .stringAttributeType
        weatherDescriptionAttribute.isOptional = true
        
        entity.properties = [
            idAttribute,
            dateAttribute,
            enjoyedWeatherAttribute,
            locationNameAttribute,
            temperatureAttribute,
            highTempAttribute,
            lowTempAttribute,
            weatherConditionAttribute,
            precipitationAttribute,
            humidityAttribute,
            windSpeedAttribute,
            weatherDescriptionAttribute
        ]
        
        model.entities = [entity]
        return model
    }
    
    /// Save changes to the context
    public func save() throws {
        if viewContext.hasChanges {
            try viewContext.save()
        }
    }
    
    /// Create a new weather entry
    public func createEntry(
        enjoyedWeather: Bool,
        location: LocationData?,
        weather: WeatherData?
    ) throws -> WeatherEntry {
        let entry = WeatherEntry(context: viewContext)
        entry.id = UUID()
        entry.date = Date()
        entry.enjoyedWeather = enjoyedWeather
        entry.locationName = location?.name
        entry.temperature = weather?.temperature ?? 0
        entry.highTemp = weather?.highTemp ?? 0
        entry.lowTemp = weather?.lowTemp ?? 0
        entry.weatherCondition = weather?.condition
        entry.precipitation = weather?.precipitation ?? 0
        entry.humidity = weather?.humidity ?? 0
        entry.windSpeed = weather?.windSpeed ?? 0
        entry.weatherDescription = weather?.description
        
        try save()
        return entry
    }
    
    /// Fetch entry for today, if exists
    public func fetchTodayEntry() -> WeatherEntry? {
        let request = WeatherEntry.fetchRequestForDate(Date())
        return try? viewContext.fetch(request).first
    }
    
    /// Fetch all entries
    public func fetchAllEntries() -> [WeatherEntry] {
        let request = WeatherEntry.allEntriesFetchRequest
        return (try? viewContext.fetch(request)) ?? []
    }
    
    /// Delete an entry
    public func delete(_ entry: WeatherEntry) throws {
        viewContext.delete(entry)
        try save()
    }
}
