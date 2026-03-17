import Foundation

struct CityTime: Identifiable {
    let id: String
    let city: String
    let country: String
    let timeZone: TimeZone

    var now: Date { Date() }

    var calendar: Calendar {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = timeZone
        return cal
    }

    var hour: Int { calendar.component(.hour, from: now) }
    var minute: Int { calendar.component(.minute, from: now) }
    var second: Int { calendar.component(.second, from: now) }

    var hour12: Int {
        let h = hour % 12
        return h == 0 ? 12 : h
    }

    var ampm: String { hour >= 12 ? "PM" : "AM" }

    var timeString: String {
        String(format: "%d:%02d", hour12, minute)
    }

    var weekday: String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "EEEE"
        return formatter.string(from: now)
    }

    var dateString: String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "MMMM d, yyyy"
        return formatter.string(from: now)
    }

    var isWorkday: Bool {
        let day = calendar.component(.weekday, from: now)
        return day >= 2 && day <= 6 // Mon=2 ... Fri=6
    }

    static let cities: [CityTime] = [
        CityTime(id: "tokyo", city: "Tokyo", country: "Japan",
                 timeZone: TimeZone(identifier: "Asia/Tokyo")!),
        CityTime(id: "la", city: "Los Angeles", country: "United States",
                 timeZone: TimeZone(identifier: "America/Los_Angeles")!),
        CityTime(id: "barcelona", city: "Barcelona", country: "Spain",
                 timeZone: TimeZone(identifier: "Europe/Madrid")!),
    ]
}
