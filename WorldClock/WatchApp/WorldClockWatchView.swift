import SwiftUI

struct WorldClockWatchView: View {
    @State private var now = Date()
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(CityTime.cities) { city in
                    WatchCityRow(city: city)
                }
            }
            .padding(.horizontal, 4)
        }
        .navigationTitle("World Clock")
        .onReceive(timer) { _ in
            now = Date()
        }
    }
}

struct WatchCityRow: View {
    let city: CityTime

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(city.city)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(city.isWorkday ? "WORK" : "OFF")
                    .font(.system(size: 8, weight: .bold))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 1)
                    .background(city.isWorkday
                        ? Color.green.opacity(0.2)
                        : Color.orange.opacity(0.2))
                    .foregroundStyle(city.isWorkday ? .green : .orange)
                    .clipShape(Capsule())
            }

            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(city.timeString)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .monospacedDigit()
                Text(city.ampm)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Text("\(city.weekday.prefix(3)), \(city.dateString)")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(8)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThinMaterial)
        }
    }
}
