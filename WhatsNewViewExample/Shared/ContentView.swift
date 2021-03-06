import SwiftUI
import WhatsNewView

struct ContentView: View {
	private enum SheetType: Identifiable {
		case configuration, plist, plistExplanation, version, versionExplanation
		case appleIntro, appleTVApp, appleResearch
		case textOnly

		var id: Int {
			hashValue
		}
	}

	@State private var activeSheet: SheetType?

	var body: some View {
		ScrollView {
			Text("WhatsNewView Examples")
				.font(.largeTitle)
				.bold()
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

				Button(action: {
					activeSheet = .plistExplanation
				}) {
					Text("Explanation Plist")
						.bold()
				}
				.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .purple))

				Button(action: {
					activeSheet = .versionExplanation
				}) {
					Text("Explanation Version Plist")
						.bold()
				}
				.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .purple))

				Divider()
					.padding()

				Group {
					Text("Apple Examples")
						.font(.title)

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
					.padding()

				Group {
					Text("Other Examples")
						.font(.title)

					Button(action: {
						activeSheet = .textOnly
					}) {
						Text("Text only")
							.bold()
					}
					.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .black))
				}
			}
		}
		.padding(.vertical)
		.sheet(item: $activeSheet) { item -> WhatsNewView? in
			switch item {
			case .configuration:
				return WhatsNewView(configuration: DefaultExampleData.configuration)
			case .plist:
				guard let path = Bundle.main.path(forResource: "WhatsNewConfiguration", ofType: "plist") else {
				  assertionFailure("The WhatsNewConfiguration.plist could not be found.")
				  return nil
				}

				return try? WhatsNewView(configurationPlistPath: path)

			case .plistExplanation:
				guard let path = Bundle.main.path(forResource: "WhatsNewConfigurationExplanation", ofType: "plist") else {
				  assertionFailure("The WhatsNewConfigurationExplanation.plist could not be found.")
				  return nil
				}

				do {
					return try WhatsNewView(configurationPlistPath: path)
				} catch {
					print("Something went wrong while initialising the WhatsNewView. Error: \(error.localizedDescription).")
				}
			case .version:
//				WhatsNewView.resetVersion()
				return try? WhatsNewView()
			case .versionExplanation:
				WhatsNewView.setLastKnownVersion("1.1.0")
				guard let path = Bundle.main.path(forResource: "WhatsNewVersionExplanation", ofType: "plist") else {
				  assertionFailure("The WhatsNewVersionExplanation.plist could not be found.")
				  return nil
				}
				do {
					return try WhatsNewView(versionPlistPath: path)
				} catch {
					print("Something went wrong while initialising the WhatsNewView. Error: \(error.localizedDescription).")
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
