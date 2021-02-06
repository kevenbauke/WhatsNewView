import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct WhatsNewConfiguration {
	public var title: String?
	public var accentedTitle: String?
	public var description: String?
	public var accentColor = Color.accentColor

	public var features: [WhatsNewFeature]?

	public var buttonTitle: String?
	public var buttonAction: (() -> ())?

	public init() {}
}
