import SwiftUI

let margin: CGFloat = 40
let listMargin: CGFloat = 25

@available(iOS 13.0.0, *)
public struct WhatsNewView: View {
	let margin: CGFloat = 40
	let listMargin: CGFloat = 25

	var plistPath: String?
	var configuration: WhatsNewConfiguration?

	public var body: some View {
		VStack(spacing: 8) {
			Group {
				Text("Welcome to ")
					.bold()
					+
					Text(Bundle.main.displayName ?? "")
					.bold()
					.foregroundColor(configuration?.accentColor ?? .accentColor)
			}
			.fixedSize(horizontal: false, vertical: true)
			.leftAligned()
			.font(.largeTitle)

			Text("This view can help you to give that extra information your user needs at certain points in your app.")
				.leftAligned()
		}
		.padding(EdgeInsets(top: margin, leading: margin, bottom: margin/2, trailing: margin))

		List {
			WhatsNewFeatureView(image: Image(systemName: "figure.wave"),
								imageColor: Color.red,
								headlineText: Text("A welcome screen"),
								bodyText: Text("Welcome your users and introduce important functionality."))
			WhatsNewFeatureView(image: Image(systemName: "megaphone.fill"),
								//						 imageColor: Color.orange,
								headlineText: Text("A new version screen"),
								bodyText: Text("Introduce your users to great new features in new versions."))
			WhatsNewFeatureView(image: Image(systemName: "text.book.closed.fill"),
								imageColor: Color.green,
								headlineText: Text("A simple how to screen"),
								bodyText: Text("Help your users and explain a screen or a feature."))
		}
		.padding(EdgeInsets(top: 0, leading: listMargin, bottom: 0, trailing: listMargin))

		Button(action: {
			print("Menu Button Tapped")
		}) {
			Text("Got it!")
				.bold()
				.frame(minWidth: 0, maxWidth: .infinity)
				.padding()
				.foregroundColor(.white)
				.background(configuration?.accentColor ?? Color.accentColor)
				.cornerRadius(10)
		}
		.padding(EdgeInsets(top: margin/2, leading: margin, bottom: margin/2, trailing: margin))
	}

	public init(configuration: WhatsNewConfiguration) {
		self.configuration = configuration
	}

	public init(plistPath: String) {
		self.plistPath = plistPath
	}
}
