import Foundation
import SwiftUI

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
public struct WhatsNewConfiguration {
	public var title: String?
	public var accentTitle: String?
	public var description: String?
	public var accentColor = Color.accentColor

	public var features: [WhatsNewFeature]?

	public var buttonTitle: String?
	public var buttonAction: (() -> ())?
	public var dismissAction: (() -> ())?

	public init() {}

	init(dictionary: Dictionary<String, Any>) {
		title = dictionary["Title"] as? String
		accentTitle = dictionary["AccentTitle"] as? String
		description = dictionary["Description"] as? String
		buttonTitle = dictionary["ButtonTitle"] as? String

		if let hexString = dictionary["AccentColor"] as? String {
			accentColor = Color(hex: hexString)
		}

		let featuresDictionaries: [Dictionary] = dictionary["Features"] as? Array<Dictionary<String, String?>> ?? []
		features = [WhatsNewFeature]()
		for featureDictionary in featuresDictionaries {
			var feature = WhatsNewFeature()
			feature.title = featureDictionary["Title"] as? String
			feature.description = featureDictionary["Description"] as? String

			if let systemImageName = featureDictionary["SystemImage"] as? String, !systemImageName.isEmpty {
				feature.image = Image(systemName: systemImageName)

				if let hexString = featureDictionary["ImageColor"] as? String {
					feature.imageColor = Color(hex: hexString)
				}
			} else if let imageName = featureDictionary["Image"] as? String, !imageName.isEmpty {
				feature.image = Image(imageName)

				if let hexString = featureDictionary["ImageColor"] as? String {
					feature.imageColor = Color(hex: hexString)
				}
			}

			features?.append(feature)
		}
	}

	init?(versionDictionary: Dictionary<String, Any>) {
		let versionRepo = WhatsNewVersionRepository()

		if versionRepo.isInitialStart, let welcomeDictionary = versionDictionary["Welcome"] as? Dictionary<String, Any> {
			self.init(dictionary: welcomeDictionary)

			if let hexString = versionDictionary["AccentColor"] as? String {
				accentColor = Color(hex: hexString)
			}

			return
		} else if versionRepo.isNewVersion {
			if let versionsDictionary = versionDictionary["Versions"] as? Dictionary<String, Any>,
			   let currentVersionDictionary = versionsDictionary[versionRepo.version] as? Dictionary<String, Any> {
				self.init(dictionary: currentVersionDictionary)

				if let defaultTitle = versionDictionary["DefaultTitle"] as? String,
				   !defaultTitle.isEmpty {
					title = defaultTitle
				}

				if let defaultAccentTitle = versionDictionary["DefaultAccentTitle"] as? String,
				   !defaultAccentTitle.isEmpty {
					accentTitle = defaultAccentTitle
				}

				if let defaultDescription = versionDictionary["DefaultDescription"] as? String,
				   !defaultDescription.isEmpty {
					description = defaultDescription
				}

				if let defaultButtonTitle = versionDictionary["DefaultButtonTitle"] as? String,
				   !defaultButtonTitle.isEmpty {
					buttonTitle = defaultButtonTitle
				}

				if let hexString = versionDictionary["AccentColor"] as? String {
					accentColor = Color(hex: hexString)
				}

				return
			}
		}

		return nil
	}
}
