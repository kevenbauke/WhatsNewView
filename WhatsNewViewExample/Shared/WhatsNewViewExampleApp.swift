import SwiftUI
import WhatsNewView

@main
struct WhatsNewViewExampleApp: App {
//	@State var whatsNewView: WhatsNewView?

    var body: some Scene {
        WindowGroup {
            ContentView()
//				.sheet(item: $whatsNewView) { $0 }
//				.onAppear {
//					WhatsNewView.setLastKnownVersion("1.2.0")
//					whatsNewView = try? WhatsNewView()
//				}
        }
    }
}
