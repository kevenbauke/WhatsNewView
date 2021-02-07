import SwiftUI
import WhatsNewView

struct ExampleData {
	static var features: [WhatsNewFeature] {
		var features = [WhatsNewFeature]()

		features.append(WhatsNewFeature(image: Image(systemName: "figure.wave"),
										imageColor: .red,
										title: "A welcome screen",
										description: "Welcome your users and introduce important functionality."))
		features.append(WhatsNewFeature(image: Image(systemName: "megaphone.fill"),
										imageColor: .orange,
										title: "A new version screen",
										description: "Introduce your users to great new features in new versions."))
		features.append(WhatsNewFeature(image: Image(systemName: "text.book.closed.fill"),
										imageColor: .green,
										title: "A simple how to screen",
										description: "Help your users and explain a screen or a feature."))

		return features
	}

	static var configurationOnly: WhatsNewConfiguration {
		var configuration = WhatsNewConfiguration()
		configuration.title = "Welcome to"
		configuration.accentTitle = "WhatsNewView"
		configuration.description = "This view can help you give that extra information your user needs at certain points in your app."
//		configuration.accentColor = .purple

		configuration.features = features
		configuration.buttonTitle = "OK"
		configuration.buttonAction = {
			print("Button tapped.")
		}
		configuration.dismissAction = {
			print("View was dismissed.")
		}

		return configuration
	}
}

extension Bundle {
	var displayName: String? {
		return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
			object(forInfoDictionaryKey: "CFBundleName") as? String
	}
}
