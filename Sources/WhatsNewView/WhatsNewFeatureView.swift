import SwiftUI

@available(iOS 13.0, *)
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
						.leftAligned()
				}
			}
		}
		.padding(.vertical)
	}
}
