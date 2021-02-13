import SwiftUI
import WhatsNewView

struct DefaultExampleData {
	static var configuration: WhatsNewConfiguration {
		var configuration = WhatsNewConfiguration()
		configuration.title = "Welcome to"
		configuration.accentTitle = "WhatsNewView"
		configuration.description = """
This view can help you give that extra information your user needs at certain points in your app.
"""

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

struct AppleIntroExampleData {
	static var configuration: WhatsNewConfiguration {
		var configuration = WhatsNewConfiguration()
		configuration.title = "Welcome to"
		configuration.accentTitle = "\nApp Store Connect"
		configuration.description = "Manage your app, view sales and trends, and respond to reviews."
		configuration.accentColor = Color(red: 0.0, green: 122/255, blue: 1.0)

		return configuration
	}
}

struct AppleTVAppExampleData {
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

		let accentColor = Color(red: 89/255, green: 184/255, blue: 250/255)
		features.append(WhatsNewFeature(image: Image(systemName: "rectangle.stack.fill"),
										imageColor: accentColor,
										title: "Watch Now",
										description: "Start watching TV shows and movies you love from your supported apps."))
		features.append(WhatsNewFeature(image: Image(systemName: "play.tv.fill"),
										imageColor: accentColor,
										title: "Library",
										description: "Find your purchases and rentals in one convenient place."))
		features.append(WhatsNewFeature(image: Image(systemName: "plus.rectangle.fill"),
										imageColor: accentColor,
										title: "Store",
										description: "Get supported app, discover new moview releases, and find popular TV shows."))

		return features
	}
}

struct AppleResearchExampleData {
	static var configuration: WhatsNewConfiguration {
		var configuration = WhatsNewConfiguration()
		configuration.title = "Research &\nYour Privacy"
		configuration.description = """
			Privacy is a fundamental human right. And it's critically important when you're taking part in research.
			To protect your privacy, the following apply to all the studies in the Research app.
			"""
		configuration.accentColor = .accentColor
		configuration.buttonTitle = "Next"

		configuration.features = features

		return configuration
	}

	static var features: [WhatsNewFeature] {
		var features = [WhatsNewFeature]()

		features.append(WhatsNewFeature(image: Image(systemName: "1.circle.fill"),
										imageColor: .accentColor,
										title: "Your data will not be sold."))
		features.append(WhatsNewFeature(image: Image(systemName: "2.circle.fill"),
										imageColor: .accentColor,
										title: "You decide which studies you join, and you can leave the study at any time."))
		features.append(WhatsNewFeature(image: Image(systemName: "3.circle.fill"),
										imageColor: .accentColor,
										title: "You control which types of data you share, and you can stop sharing your data at anytime."))
		features.append(WhatsNewFeature(image: Image(systemName: "4.circle.fill"),
										imageColor: .accentColor,
										title: "Studies must tell you how your data supports their research."))

		return features
	}
}

struct TextOnlyExampleData {
	static var configuration: WhatsNewConfiguration {
		var configuration = WhatsNewConfiguration()
		configuration.title = "How To"
		configuration.accentTitle = "Only Text"
		configuration.buttonTitle = "Yeah!"

		configuration.features = features

		return configuration
	}

	static var features: [WhatsNewFeature] {
		var features = [WhatsNewFeature]()

		features.append(WhatsNewFeature(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit"))
		features.append(WhatsNewFeature(title: "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."))
		features.append(WhatsNewFeature(title: """
							Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea
commodo consequat.
"""))
		features.append(WhatsNewFeature(description: """
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"""))

		return features
	}
}

extension Bundle {
	var displayName: String? {
		return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
			object(forInfoDictionaryKey: "CFBundleName") as? String
	}
}
