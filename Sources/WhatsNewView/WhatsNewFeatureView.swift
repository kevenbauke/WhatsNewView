import SwiftUI

@available(iOS 13.0, *)
struct WhatsNewFeatureView: View {
	let image: Image?
	let imageColor: Color?
	let headlineText: Text?
	let bodyText: Text

	init(image: Image? = nil, imageColor: Color? = .black, headlineText: Text? = nil, bodyText: Text) {
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
				.foregroundColor(imageColor ?? Color.black)

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
