import Foundation
import SwiftUI

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
public struct WhatsNewConfiguration {
	public var title: String? {
		didSet {
			title = title?.replacingKeyWords()
		}
	}

	public var accentTitle: String? {
		didSet {
			accentTitle = accentTitle?.replacingKeyWords()
		}
	}

	public var description: String? {
		didSet {
			description = description?.replacingKeyWords()
		}
	}

	public var accentColor = Color.accentColor

	public var features: [WhatsNewFeature]?

	public var buttonTitle: String? {
		didSet {
			buttonTitle = buttonTitle?.replacingKeyWords()
		}
	}

	public var buttonAction: (() -> ())?
	public var dismissAction: (() -> ())?

	public init() {}

	init(dictionary: Dictionary<String, Any>) {
		title = (dictionary["Title"] as? String)?.replacingKeyWords()
		accentTitle = (dictionary["AccentTitle"] as? String)?.replacingKeyWords()
		description = (dictionary["Description"] as? String)?.replacingKeyWords()
		buttonTitle = (dictionary["ButtonTitle"] as? String)?.replacingKeyWords()

		if let hexString = dictionary["AccentColor"] as? String, !hexString.isEmpty {
			accentColor = Color(hex: hexString) ?? .accentColor
		}

		let featuresDictionaries: [Dictionary] = dictionary["Features"] as? Array<Dictionary<String, String?>> ?? []
		features = [WhatsNewFeature]()
		for featureDictionary in featuresDictionaries {
			var feature = WhatsNewFeature()
			feature.title = (featureDictionary["Title"] as? String)?.replacingKeyWords()
			feature.description = (featureDictionary["Description"] as? String)?.replacingKeyWords()

			if let systemImageName = featureDictionary["SystemImage"] as? String, !systemImageName.isEmpty {
				feature.image = Image(systemName: systemImageName)
			} else if let imageName = featureDictionary["Image"] as? String, !imageName.isEmpty {
				feature.image = Image(imageName)
			}

			if let hexString = featureDictionary["ImageColor"] as? String, !hexString.isEmpty {
				feature.imageColor = Color(hex: hexString)
			} else {
				feature.imageColor = accentColor
			}

			features?.append(feature)
		}
	}

	init?(versionDictionary: Dictionary<String, Any>) {
		func checkAndSetDefaultStrings() {
			if title.isEmptyOrNil, let defaultTitle = versionDictionary["DefaultTitle"] as? String,
			   !defaultTitle.isEmpty {
				title = defaultTitle.replacingKeyWords()
			}

			if accentTitle.isEmptyOrNil, let defaultAccentTitle = versionDictionary["DefaultAccentTitle"] as? String,
			   !defaultAccentTitle.isEmpty {
				accentTitle = defaultAccentTitle.replacingKeyWords()
			}

			if description.isEmptyOrNil, let defaultDescription = versionDictionary["DefaultDescription"] as? String,
			   !defaultDescription.isEmpty {
				description = defaultDescription.replacingKeyWords()
			}

			if buttonTitle.isEmptyOrNil, let defaultButtonTitle = versionDictionary["DefaultButtonTitle"] as? String,
			   !defaultButtonTitle.isEmpty {
				buttonTitle = defaultButtonTitle.replacingKeyWords()
			}

			if accentColor == .accentColor, let hexString = versionDictionary["AccentColor"] as? String {
				accentColor = Color(hex: hexString) ?? .accentColor
			}
		}

		if WhatsNewVersionRepository.isInitialStart, let welcomeDictionary = versionDictionary["Welcome"] as? Dictionary<String, Any>, !welcomeDictionary.isEmpty {
			self.init(dictionary: welcomeDictionary)
			checkAndSetDefaultStrings()

			return
		} else if WhatsNewVersionRepository.isNewVersion {
			if let versionsDictionary = versionDictionary["Versions"] as? Dictionary<String, Any>,
			   let currentVersionDictionary = versionsDictionary[WhatsNewVersionRepository.bundleVersion] as? Dictionary<String, Any> {
				self.init(dictionary: currentVersionDictionary)
				checkAndSetDefaultStrings()

				return
			}
		}

		return nil
	}
}

private extension String {
	private struct KeyWords {
		static let versionString = "$(Version)"
		static let appnameString = "$(AppName)"
	}

	func replacingKeyWords() -> String {
		replacingOccurrences(of: KeyWords.versionString, with: WhatsNewVersionRepository.bundleVersion, options: .caseInsensitive)
			.replacingOccurrences(of: KeyWords.appnameString, with: Bundle.main.displayName ?? "CFBundleName could not be read", options: .caseInsensitive)
	}
}

private extension Bundle {
	var displayName: String? {
		return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
			object(forInfoDictionaryKey: "CFBundleName") as? String
	}
}
