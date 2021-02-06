import SwiftUI

@available(iOS 13.0, *)
public struct WhatsNewFeature: Identifiable {
	public var id: ObjectIdentifier
	public var image: Image?
	public var imageColor: Color?
	public var title: String?
	public var description: String
}
