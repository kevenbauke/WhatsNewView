import SwiftUI

@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
public struct WhatsNewFeature: Identifiable {
	public var id = UUID()
	public var image: Image?
	public var imageColor: Color?
	public var title: String?
	public var description: String?

	public init(image: Image? = nil, imageColor: Color? = nil, title: String? = nil, description: String? = nil) {
		self.image = image
		self.imageColor = imageColor
		self.title = title
		self.description = description
	}
}
