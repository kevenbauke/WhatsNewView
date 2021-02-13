import SwiftUI
import WhatsNewView

@main
struct WhatsNewViewExampleApp: App {
	@State var whatsNewView: WhatsNewView?

    var body: some Scene {
        WindowGroup {
            ContentView()
//				.sheet(item: $whatsNewView) { $0 }
				.onAppear {
					WhatsNewView.resetVersion()
					if let path = Bundle.main.path(forResource: "WhatsNewVersion", ofType: "plist") {
					   whatsNewView = WhatsNewView(versionPlistPath: path)
					}
				}
        }
    }
}
