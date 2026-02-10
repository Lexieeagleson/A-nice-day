import Foundation
import CoreData

/// Represents a single daily weather entry with user response
/// This is the Core Data entity that stores each day's log
@objc(WeatherEntry)
public class WeatherEntry: NSManagedObject, Identifiable {
    @NSManaged public var id: UUID
    @NSManaged public var date: Date
    @NSManaged public var enjoyedWeather: Bool // True = Yes, False = No
    @NSManaged public var locationName: String?
    @NSManaged public var temperature: Double
    @NSManaged public var highTemp: Double
    @NSManaged public var lowTemp: Double
    @NSManaged public var weatherCondition: String?
    @NSManaged public var precipitation: Double
    @NSManaged public var humidity: Double
    @NSManaged public var windSpeed: Double
    @NSManaged public var weatherDescription: String?
    
    /// Calendar day for checking if entry exists for today
    var calendarDay: Date {
        Calendar.current.startOfDay(for: date)
    }
}

extension WeatherEntry {
    /// Fetch request for all entries sorted by date descending
    static var allEntriesFetchRequest: NSFetchRequest<WeatherEntry> {
        let request = NSFetchRequest<WeatherEntry>(entityName: "WeatherEntry")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \WeatherEntry.date, ascending: false)]
        return request
    }
    
    /// Check if an entry exists for a specific date
    static func fetchRequestForDate(_ date: Date) -> NSFetchRequest<WeatherEntry> {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let request = NSFetchRequest<WeatherEntry>(entityName: "WeatherEntry")
        request.predicate = NSPredicate(format: "date >= %@ AND date < %@", startOfDay as NSDate, endOfDay as NSDate)
        request.fetchLimit = 1
        return request
    }
}
