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

	init(dictionary: Dictionary<String, Any>) {
		title = dictionary["Title"] as? String
		accentedTitle = dictionary["AccentedTitle"] as? String
		description = dictionary["Description"] as? String
		buttonTitle = dictionary["ButtonTitle"] as? String

		let featuresDictionaries: [Dictionary] = dictionary["Features"] as? Array<Dictionary<String, String?>> ?? []
		features = [WhatsNewFeature]()
		for featureDictionary in featuresDictionaries {
			let description = featureDictionary["Description"] as? String
			var feature = WhatsNewFeature(description: description ?? "No description found.")
			feature.title = featureDictionary["Title"] as? String

			if let imageName = featureDictionary["Image"] as? String {
				feature.image = Image(systemName: imageName)
				feature.imageColor = Color("Red")
			}

			features?.append(feature)
		}
	}
}
