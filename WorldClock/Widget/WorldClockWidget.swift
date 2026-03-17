import WidgetKit
import SwiftUI

struct WorldClockEntry: TimelineEntry {
    let date: Date
    let cities: [CityTime]
}

struct WorldClockProvider: TimelineProvider {
    func placeholder(in context: Context) -> WorldClockEntry {
        WorldClockEntry(date: Date(), cities: CityTime.cities)
    }

    func getSnapshot(in context: Context, completion: @escaping (WorldClockEntry) -> Void) {
        completion(WorldClockEntry(date: Date(), cities: CityTime.cities))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<WorldClockEntry>) -> Void) {
        // Update every minute
        let now = Date()
        var entries: [WorldClockEntry] = []
        for offset in 0..<60 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: offset, to: now)!
            entries.append(WorldClockEntry(date: entryDate, cities: CityTime.cities))
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

// MARK: - Widget Views

struct WorldClockWidgetSmall: View {
    let entry: WorldClockEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ForEach(CityTime.cities) { city in
                CompactCityView(city: city)
                if city.id != CityTime.cities.last?.id {
                    Divider()
                }
            }
        }
        .padding(4)
    }
}

struct WorldClockWidgetMedium: View {
    let entry: WorldClockEntry

    var body: some View {
        HStack(spacing: 12) {
            ForEach(CityTime.cities) { city in
                VStack(alignment: .leading, spacing: 4) {
                    Text(city.city)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.secondary)

                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text(city.timeString)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .monospacedDigit()
                        Text(city.ampm)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }

                    Text(city.dateString)
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                        .lineLimit(1)

                    HStack(spacing: 4) {
                        Text(city.weekday.prefix(3).uppercased())
                            .font(.caption2)
                            .fontWeight(.semibold)

                        Text(city.isWorkday ? "W" : "E")
                            .font(.system(size: 8, weight: .bold))
                            .padding(2)
                            .background(city.isWorkday
                                ? Color.green.opacity(0.2)
                                : Color.orange.opacity(0.2))
                            .foregroundStyle(city.isWorkday ? .green : .orange)
                            .clipShape(Circle())
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(4)
    }
}

// MARK: - Widget Definition

struct WorldClockWidget: Widget {
    let kind = "WorldClockWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: WorldClockProvider()) { entry in
            Group {
                if #available(macOS 14.0, iOS 17.0, watchOS 10.0, *) {
                    WorldClockWidgetMedium(entry: entry)
                        .containerBackground(.fill.tertiary, for: .widget)
                } else {
                    WorldClockWidgetMedium(entry: entry)
                        .padding()
                        .background()
                }
            }
        }
        .configurationDisplayName("World Clock")
        .description("Tokyo · Los Angeles · Barcelona")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
