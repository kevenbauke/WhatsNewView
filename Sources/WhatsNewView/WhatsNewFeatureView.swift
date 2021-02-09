import SwiftUI

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
struct WhatsNewFeatureView: View {
	private let feature: WhatsNewFeature

	init(feature: WhatsNewFeature) {
		self.feature = feature
	}

	var body: some View {
		HStack {
			feature.image?
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 50, height: 50)
				.padding(.trailing)
				.foregroundColor(feature.imageColor ?? .primary)

			VStack(spacing: 4) {
				if let title = feature.title {
					Text(title)
						.font(.headline)
						.leftAligned()
				}

				if let description = feature.description {
					Text(description)
						.foregroundColor(.gray)
						.leftAligned()
				}
			}
		}
		.padding(.vertical)
	}
}
