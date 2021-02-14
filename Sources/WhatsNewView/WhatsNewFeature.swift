import SwiftUI

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
/// An object for each feature.
public struct WhatsNewFeature: Identifiable {
	/// A unique id to differentiate the different instances and to conform to Identifiable.
	public var id = UUID()
	/// The image shown on the left of the `WhatsNewFeatureView`.
	var image: Image?
	/// The color of the `image`.
	var imageColor: Color?
	/// The title of the view.
	var title: String?
	/// The description of the feature.
	var description: String?

	/// The default initializer of the object.
	/// - Note: Leaving any of these results in not showing them int the `WhatsNewFeatureView`.
	/// - Parameters:
	///   - image: The image shown on the left of the `WhatsNewFeatureView`.
	///   - imageColor: The color of the `image`. Default: `Color.primary`.
	///   - title: The title of the view.
	///   - description: The description of the feature.
	public init(image: Image? = nil, imageColor: Color? = .primary, title: String? = nil, description: String? = nil) {
		self.image = image
		self.imageColor = imageColor
		self.title = title
		self.description = description
	}
}
