import SwiftUI

struct CityClockView: View {
    let city: CityTime
    let accentColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // City & country
            Text(city.city.uppercased())
                .font(.caption)
                .fontWeight(.semibold)
                .tracking(1.5)
                .foregroundStyle(.secondary)
            Text(city.country)
                .font(.caption2)
                .foregroundStyle(.tertiary)

            Spacer().frame(height: 4)

            // Time
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(city.timeString)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .monospacedDigit()
                Text(city.ampm)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }

            // Date
            Text(city.dateString)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            // Day + badge
            HStack(spacing: 8) {
                Text(city.weekday)
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(city.isWorkday ? "WORKDAY" : "WEEKEND")
                    .font(.system(size: 10, weight: .semibold))
                    .tracking(0.5)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(city.isWorkday
                        ? Color.green.opacity(0.15)
                        : Color.orange.opacity(0.15))
                    .foregroundStyle(city.isWorkday ? .green : .orange)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(alignment: .top) {
                    accentColor
                        .frame(height: 3)
                        .clipShape(UnevenRoundedRectangle(
                            topLeadingRadius: 16, topTrailingRadius: 16))
                }
        }
    }
}

struct CompactCityView: View {
    let city: CityTime

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(city.city)
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)

            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(city.timeString)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .monospacedDigit()
                Text(city.ampm)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Text(city.weekday.prefix(3).uppercased())
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundStyle(city.isWorkday ? .green : .orange)
        }
    }
}
