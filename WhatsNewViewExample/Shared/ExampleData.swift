import SwiftUI
import WhatsNewView

struct DefaultExampleData {
	static var configuration: WhatsNewConfiguration {
		var configuration = WhatsNewConfiguration()
		configuration.title = "Welcome to"
		configuration.accentTitle = "WhatsNewView"
		configuration.description = "This view can help you give that extra information your user needs at certain points in your app."

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
}

struct IntroExampleData {
	static var configuration: WhatsNewConfiguration {
		var configuration = WhatsNewConfiguration()
		configuration.title = "Welcome to"
		configuration.accentTitle = "\nApp Store Connect"
		configuration.description = "Manage your app, view sales and trends, and respond to reviews."
		configuration.accentColor = Color(red: 0.0, green: 122/255, blue: 1.0)
		configuration.buttonTitle = "OK"

		return configuration
	}
}

struct TVAppExampleData {
	static var configuration: WhatsNewConfiguration {
		var configuration = WhatsNewConfiguration()
		configuration.title = "Welcome\nto the TV app."
		configuration.description = "The Videos app is now TV. Easily keep up with TV shows and discover new movies."
		configuration.accentColor = Color(red: 89/255, green: 184/255, blue: 250/255)
		configuration.buttonTitle = "Continue"

		configuration.features = features

		return configuration
	}

	static var features: [WhatsNewFeature] {
		var features = [WhatsNewFeature]()

		features.append(WhatsNewFeature(image: Image(systemName: "rectangle.stack.fill"),
										imageColor: configuration.accentColor,
										title: "Watch Now",
										description: "Start watching TV shows and movies you love from your supported apps."))
		features.append(WhatsNewFeature(image: Image(systemName: "play.tv.fill"),
										imageColor: configuration.accentColor,
										title: "Library",
										description: "Find your purchases and rentals in one convenient place."))
		features.append(WhatsNewFeature(image: Image(systemName: "plus.rectangle.fill"),
										imageColor: configuration.accentColor,
										title: "Store",
										description: "Get supported app, discover new moview releases, and find popular TV shows."))

		return features
	}
}

extension Bundle {
	var displayName: String? {
		return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
			object(forInfoDictionaryKey: "CFBundleName") as? String
	}
}
