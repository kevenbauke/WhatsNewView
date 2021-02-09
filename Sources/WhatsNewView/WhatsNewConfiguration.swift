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
		title = dictionary["Title"] as? String
		accentTitle = dictionary["AccentTitle"] as? String
		description = dictionary["Description"] as? String
		buttonTitle = dictionary["ButtonTitle"] as? String

		if let hexString = dictionary["AccentColor"] as? String, !hexString.isEmpty {
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
		if WhatsNewVersionRepository.isInitialStart, let welcomeDictionary = versionDictionary["Welcome"] as? Dictionary<String, Any> {
			self.init(dictionary: welcomeDictionary)

			if let hexString = versionDictionary["AccentColor"] as? String {
				accentColor = Color(hex: hexString)
			}

			return
		} else if WhatsNewVersionRepository.isNewVersion {
			if let versionsDictionary = versionDictionary["Versions"] as? Dictionary<String, Any>,
			   let currentVersionDictionary = versionsDictionary[WhatsNewVersionRepository.version] as? Dictionary<String, Any> {
				self.init(dictionary: currentVersionDictionary)

				if title.isEmptyOrNil, let defaultTitle = versionDictionary["DefaultTitle"] as? String,
				   !defaultTitle.isEmpty {
					title = defaultTitle
				}

				if accentTitle.isEmptyOrNil, let defaultAccentTitle = versionDictionary["DefaultAccentTitle"] as? String,
				   !defaultAccentTitle.isEmpty {
					accentTitle = defaultAccentTitle
				}

				if description.isEmptyOrNil, let defaultDescription = versionDictionary["DefaultDescription"] as? String,
				   !defaultDescription.isEmpty {
					description = defaultDescription
				}

				if buttonTitle.isEmptyOrNil, let defaultButtonTitle = versionDictionary["DefaultButtonTitle"] as? String,
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

private extension Optional where Wrapped: Collection {
	var isEmptyOrNil: Bool {
		return self?.isEmpty ?? true
	}
}

private extension String {
	private struct KeyWords {
		static let versionString = "$(Version)"
		static let appnameString = "$(AppName)"
	}

	func replacingKeyWords() -> String {
		replacingOccurrences(of: KeyWords.versionString, with: WhatsNewVersionRepository.version, options: .caseInsensitive)
			.replacingOccurrences(of: KeyWords.appnameString, with: Bundle.main.displayName ?? "CFBundleName could not be read", options: .caseInsensitive)
	}
}

private extension Bundle {
	var displayName: String? {
		return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
			object(forInfoDictionaryKey: "CFBundleName") as? String
	}
}
