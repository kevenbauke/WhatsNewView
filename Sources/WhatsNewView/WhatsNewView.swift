import SwiftUI

let margin: CGFloat = 40
let listMargin: CGFloat = 25

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
public struct WhatsNewView: View, Identifiable {
	public let id = UUID()
	public var configuration: WhatsNewConfiguration?
	
	private let margin: CGFloat = 40
	private let listMargin: CGFloat = 25

	@Environment(\.presentationMode) private var presentationMode

	public var body: some View {
		VStack(spacing: 8) {
			Group {
				if let title = configuration?.title {
					if let accentTitle = configuration?.accentTitle {
						Text(title)
							.bold()
						+
						Text(" " + accentTitle)
							.bold()
							.foregroundColor(configuration?.accentColor ?? .accentColor)
					} else {
						Text(title)
							.bold()
					}
				} else {
					if let accentTitle = configuration?.accentTitle {
						Text(accentTitle)
							.bold()
							.foregroundColor(configuration?.accentColor ?? .accentColor)
					}
				}
			}
			.fixedSize(horizontal: false, vertical: true)
			.leftAligned()
			.font(Font.system(size: 40))

			Group {
				if let description = configuration?.description {
					Text(description)
				}
			}
			.leftAligned()
		}
		.padding(EdgeInsets(top: margin, leading: margin, bottom: margin/2, trailing: margin))

		if let features = configuration?.features {
			List(features) { feature in
				WhatsNewFeatureView(feature: feature)
			}
			.padding(EdgeInsets(top: 0, leading: listMargin, bottom: 0, trailing: listMargin))
		}

		Button(action: {
			if let action = configuration?.buttonAction {
				action()
			}

			presentationMode.wrappedValue.dismiss()
		}) {
			Group {
				if let buttonTitle = configuration?.buttonTitle {
					Text(buttonTitle)
						.bold()
				}
			}
		}
		.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: configuration?.accentColor ?? Color.accentColor))
		.padding(EdgeInsets(top: margin/2, leading: margin, bottom: margin/2, trailing: margin))
		.onDisappear {
			if let dismissAction = configuration?.dismissAction {
				dismissAction()
			}
			WhatsNewVersionRepository.setCurrentVersion()
		}
	}

	public init(configuration: WhatsNewConfiguration) {
		self.configuration = configuration
	}

	public init?(configurationPlistPath: String) {
		if let configurationDictionary = NSDictionary(contentsOfFile: configurationPlistPath) as? Dictionary<String, Any> {
			configuration = WhatsNewConfiguration(dictionary: configurationDictionary)
		} else {
			return nil
		}
	}

	public init?(versionPlistPath: String) {
		if let versionDictionary = NSDictionary(contentsOfFile: versionPlistPath) as? Dictionary<String, Any> {
			if let configuration = WhatsNewConfiguration(versionDictionary: versionDictionary) {
				self.configuration = configuration
			} else {
				return nil
			}
		} else {
			return nil
		}
	}

	public static func resetVersion() {
		WhatsNewVersionRepository.lastKnownVersion = nil
	}

	public static func setLastKnownVersion(_ version: String?) {
		WhatsNewVersionRepository.lastKnownVersion = version
	}
}

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
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
	.scaleEffect(configuration.isPressed ? 0.97 : 1)
	.animation(.easeOut)
  }
}
