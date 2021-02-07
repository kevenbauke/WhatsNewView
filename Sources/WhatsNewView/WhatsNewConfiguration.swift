import Foundation
import SwiftUI

@available(iOS 13.0, *)
public struct WhatsNewConfiguration {
	public var title: String?
	public var accentTitle: String?
	public var description: String?
	public var accentColor = Color.accentColor

	public var features: [WhatsNewFeature]?

	public var buttonTitle: String?
	public var buttonAction: (() -> ())?

	public init() {}

	init(dictionary: Dictionary<String, Any>) {
		title = dictionary["Title"] as? String
		accentTitle = dictionary["AccentTitle"] as? String
		description = dictionary["Description"] as? String
		buttonTitle = dictionary["ButtonTitle"] as? String

		if let hexString = dictionary["AccentColor"] as? String {
			accentColor = Color(UIColor(hexString: hexString))
		}

		let featuresDictionaries: [Dictionary] = dictionary["Features"] as? Array<Dictionary<String, String?>> ?? []
		features = [WhatsNewFeature]()
		for featureDictionary in featuresDictionaries {
			let description = featureDictionary["Description"] as? String
			var feature = WhatsNewFeature(description: description ?? "No description found.")
			feature.title = featureDictionary["Title"] as? String

			if let systemImageName = featureDictionary["SystemImage"] as? String, !systemImageName.isEmpty {
				feature.image = Image(systemName: systemImageName)

				if let hexString = featureDictionary["ImageColor"] as? String {
					feature.imageColor = Color(UIColor(hexString: hexString))
				}
			} else if let imageName = featureDictionary["Image"] as? String, !imageName.isEmpty {
				feature.image = Image(imageName)

				if let hexString = featureDictionary["ImageColor"] as? String {
					feature.imageColor = Color(UIColor(hexString: hexString))
				}
			}

			features?.append(feature)
		}
	}
}
