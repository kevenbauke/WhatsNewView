import SwiftUI

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
/// Represents as single feature containing an image, a title and a description.
struct WhatsNewFeatureView: View {
	/// The feature providing the information for this view. See `WhatsNewFeature` for more details.
	private let feature: WhatsNewFeature

	/// Default initialiser of this view.
	/// - Parameter feature: The feature holding all the information for this view. See `WhatsNewFeature` for more details.
	init(feature: WhatsNewFeature) {
		self.feature = feature
	}

	/// The content of the view.
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
						.foregroundColor(.secondary)
						.leftAligned()
				}
			}
		}
		.padding(.vertical)
	}
}
