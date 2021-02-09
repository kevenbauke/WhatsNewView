import SwiftUI
import WhatsNewView

struct ContentView: View {
	private enum SheetType: Identifiable {
		case configuration, plist, version
		case appleIntro, appleTVApp, appleResearch
		case textOnly

		var id: Int {
			hashValue
		}
	}

	@State private var activeSheet: SheetType?

	var body: some View {
		Text("WhatsNewView Example")
			.font(.largeTitle)
			.padding()

		VStack(spacing: 8) {
			Button(action: {
				activeSheet = .configuration
			}) {
				Text("Configuration (Code only)")
					.bold()
			}
			.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .red))

			Button(action: {
				activeSheet = .plist
			}) {
				Text("Plist")
					.bold()
			}
			.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .orange))

			Button(action: {
				activeSheet = .version
			}) {
				Text("Version Plist")
					.bold()
			}
			.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .green))

			Divider()

			Group {
				Text("App Examples")

				Button(action: {
					activeSheet = .appleIntro
				}) {
					Text("Apple Intro")
						.bold()
				}
				.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .black))

				Button(action: {
					activeSheet = .appleTVApp
				}) {
					Text("Apple TVApp")
						.bold()
				}
				.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .black))

				Button(action: {
					activeSheet = .appleResearch
				}) {
					Text("Apple Research")
						.bold()
				}
				.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .black))
			}

			Divider()

			Group {
				Text("Other Examples")

				Button(action: {
					activeSheet = .textOnly
				}) {
					Text("Text only")
						.bold()
				}
				.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .black))
			}
		}
		.padding(.vertical)
		.sheet(item: $activeSheet) { item -> WhatsNewView? in
			switch item {
			case .configuration:
				return WhatsNewView(configuration: DefaultExampleData.configuration)
			case .plist:
				if let path = Bundle.main.path(forResource: "WhatsNewConfiguration", ofType: "plist"),
				   let whatsNewView = WhatsNewView(configurationPlistPath: path) {
					return whatsNewView
				}
			case .version:
				if let path = Bundle.main.path(forResource: "WhatsNewVersion", ofType: "plist"),
				   let whatsNewView = WhatsNewView(versionPlistPath: path) {
					return whatsNewView
				}
			case .appleIntro:
				return WhatsNewView(configuration: AppleIntroExampleData.configuration)
			case .appleTVApp:
				return WhatsNewView(configuration: AppleTVAppExampleData.configuration)
			case .appleResearch:
				return WhatsNewView(configuration: AppleResearchExampleData.configuration)
			case .textOnly:
				return WhatsNewView(configuration: TextOnlyExampleData.configuration)
			}

			return nil
		}
		.onAppear {
//			WhatsNewView.setLastKnownVersion(nil)
		}
	}
}

private struct RoundedRectangleButtonStyle: ButtonStyle {
	var backgroundColor: Color

  func makeBody(configuration: Configuration) -> some View {
	HStack {
	  configuration.label
		.frame(minWidth: 0, maxWidth: .infinity)
		.padding()
		.foregroundColor(.white)
		.background(backgroundColor)
		.cornerRadius(10)
	}
	.padding(.horizontal)
	.scaleEffect(configuration.isPressed ? 0.97 : 1)
	.animation(.easeOut)
  }
}
