import SwiftUI

@main
struct WorldClockApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if os(macOS)
        .windowStyle(.titleBar)
        .defaultSize(width: 900, height: 340)
        #endif
    }
}

struct ContentView: View {
    @State private var now = Date()
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    let accents: [Color] = [.red, .cyan, .yellow]

    var body: some View {
        #if os(watchOS)
        WorldClockWatchView()
        #else
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(Array(CityTime.cities.enumerated()), id: \.element.id) { i, city in
                    CityClockView(city: city, accentColor: accents[i])
                        .frame(minWidth: 240)
                }
            }
            .padding()
        }
        .background(Color(.black).opacity(0.95))
        .onReceive(timer) { _ in
            now = Date()
        }
        #endif
    }
}
