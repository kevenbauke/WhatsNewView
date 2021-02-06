import SwiftUI

let margin: CGFloat = 40
let listMargin: CGFloat = 25

@available(iOS 13.0.0, *)
public struct WhatsNewView: View {
	private let margin: CGFloat = 40
	private let listMargin: CGFloat = 25

	private var plistPath: String?
	private var configuration: WhatsNewConfiguration?

	@Environment(\.presentationMode) private var presentationMode

	public var body: some View {
		VStack(spacing: 8) {
			Group {
				if let title = configuration?.title {
					if let accentedTitle = configuration?.accentedTitle {
						Text(title)
							.bold()
						+
						Text(" " + accentedTitle)
							.bold()
							.foregroundColor(configuration?.accentColor ?? .accentColor)
					} else {
						Text(title)
							.bold()
					}
				} else {
					Text("Welcome to ")
						.bold()
						+
					Text(Bundle.main.displayName ?? "")
						.bold()
						.foregroundColor(configuration?.accentColor ?? .accentColor)
				}
			}
			.fixedSize(horizontal: false, vertical: true)
			.leftAligned()
			.font(.largeTitle)

			Group {
				if let description = configuration?.description {
					Text(description)
				} else {
					Text("This view can help you to give that extra information your user needs at certain points in your app.")
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

			self.presentationMode.wrappedValue.dismiss()
		}) {
			Group {
				if let buttonTitle = configuration?.buttonTitle {
					Text(buttonTitle)
						.bold()
				} else {
					Text("Got it!")
						.bold()
				}
			}
		}
		.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: configuration?.accentColor ?? Color.accentColor))
		.padding(EdgeInsets(top: margin/2, leading: margin, bottom: margin/2, trailing: margin))
	}

	public init(configuration: WhatsNewConfiguration) {
		self.configuration = configuration
	}

	public init(plistPath: String, configuration: WhatsNewConfiguration? = nil) {
		self.plistPath = plistPath
		self.configuration = configuration
	}
}

@available(iOS 13.0, *)
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
