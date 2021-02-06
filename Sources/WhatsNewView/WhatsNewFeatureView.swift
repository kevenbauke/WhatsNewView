import SwiftUI

@available(iOS 13.0, *)
struct WhatsNewFeatureView: View {
	private let image: Image?
	private let imageColor: Color?
	private let headlineText: Text?
	private let bodyText: Text

	init(image: Image? = nil, imageColor: Color? = nil, headlineText: Text? = nil, bodyText: Text) {
		self.image = image
		self.imageColor = imageColor
		self.headlineText = headlineText
		self.bodyText = bodyText
	}

	var body: some View {
		HStack {
			image?
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 50, height: 50)
				.padding(.trailing)
				.foregroundColor(imageColor ?? .primary)

			VStack(spacing: 4) {
				headlineText?
					.font(.headline)
					.leftAligned()
				bodyText
					.leftAligned()
			}
		}
		.padding(.vertical)
	}
}
