import XCTest
import SwiftUI
@testable import WhatsNewView

@available(iOS 13, *)
final class WhatsNewConfigurationTests: XCTestCase {
	private lazy var defaultConfiguationDictionary = {
		return [
			"Title": "Normal title",
			"AccentTitle": "Title for the accent",
			"Description": "This is a description with the version in it: $(version)",
			"ButtonTitle": "A button title with the name $(appName) in it.",
			"AccentColor": "#FF0000",
			"Features": [
				[
					"Title": "Feature title with appname: $(appName).",
					"Description": "Feature description with version: $(version).",
					"SystemImage": "square.and.arrow.up",
					"Image": "Name of a normal image name",
					"ImageColor": "#FF0000",
				]
			],
		] as [String : Any]
	}()

	private lazy var defaultVersionDictionary = {
		return [
			"DefaultTitle": "Default title",
			"DefaultAccentTitle": "Default title for the accent",
			"DefaultDescription": "Default description with the version in it: $(version)",
			"DefaultButtonTitle": "Default button title with the name $(appName) in it.",
			"DefaultAccentColor": "#FF0000",
			"Welcome": [
				"Title": "Welcome title",
				"AccentTitle": "Welcome title for the accent",
				"Description": "Welcome description with the version in it: $(version)",
				"ButtonTitle": "Welcome button title with the name $(appName) in it.",
				"AccentColor": "#FFFF00",
				"Features": [
					[
						"Title": "Welcome feature title with appname: $(appName).",
						"Description": "Welcome feature description with version: $(version).",
						"SystemImage": "square.and.arrow.up",
						"Image": "Name of a normal image name",
						"ImageColor": "#FF0000",
					]
				]
			],
			"Versions": [
				"CFBundleShortVersionString could not be found": [
					"Title": "Version 1.1.1 title",
					"AccentTitle": "Version 1.1.1 Title for the accent",
					"Description": "Version 1.1.1 description with the version in it: $(version)",
					"ButtonTitle": "Version 1.1.1 button title with the name $(appName) in it.",
					"AccentColor": "#FFFFFF",
					"Features": [
						[
							"Title": "Version 1.1.1 feature title with appname: $(appName).",
							"Description": "Version 1.1.1 feature description with version: $(version).",
							"SystemImage": "square.and.arrow.up",
							"Image": "Name of a normal image name",
							"ImageColor": "#FF0000",
						]
					]
				]
			]
		] as [String : Any]
	}()

	func testInit() {
		let config = WhatsNewConfiguration()
		XCTAssertNotNil(config)
		XCTAssertNil(config.title)
	}

	func testInitDictionary() {
		let dictionary = defaultConfiguationDictionary

		let config = WhatsNewConfiguration(dictionary: dictionary)
		XCTAssertEqual(config.title, "Normal title")
		XCTAssertEqual(config.description, "This is a description with the version in it: CFBundleShortVersionString could not be found")
		XCTAssertEqual(config.buttonTitle, "A button title with the name xctest in it.")
		XCTAssertEqual(config.accentColor, Color(red: 1, green: 0, blue: 0))
		XCTAssertEqual(config.features?.count, 1)
		XCTAssertEqual(config.features?.first?.title, "Feature title with appname: xctest.")
		XCTAssertEqual(config.features?.first?.description, "Feature description with version: CFBundleShortVersionString could not be found.")
		XCTAssertEqual(config.features?.first?.image, Image(systemName: "square.and.arrow.up"))
		XCTAssertEqual(config.features?.first?.imageColor, Color(red: 1, green: 0, blue: 0))
	}

	func testInitDictionaryFallbacks() {
		var dictionary = [String : Any]()
		dictionary["AccentColor"] = "Invalid color"

		dictionary["Features"] = [
			[
				"Image": "square.and.arrow.up"
			]
		]

		var config = WhatsNewConfiguration(dictionary: dictionary)
		XCTAssertEqual(config.accentColor, Color.accentColor)
		
		XCTAssertEqual(config.features?.count, 1)
		XCTAssertNil(config.features?.first?.title)
		XCTAssertNil(config.features?.first?.description)
		XCTAssertEqual(config.features?.first?.image, Image("square.and.arrow.up"))
		XCTAssertEqual(config.features?.first?.imageColor, .accentColor)

		dictionary.removeValue(forKey: "Features")

		config = WhatsNewConfiguration(dictionary: dictionary)
		XCTAssertEqual(config.features?.count, 0)
	}

	func testInitVersionWelcomeDictionary() {
		let dictionary = defaultVersionDictionary
		WhatsNewVersionRepository.lastKnownVersion = nil

		let config = WhatsNewConfiguration(versionDictionary: dictionary)
		XCTAssertEqual(config?.title, "Welcome title")
		XCTAssertEqual(config?.description, "Welcome description with the version in it: CFBundleShortVersionString could not be found")
		XCTAssertEqual(config?.buttonTitle, "Welcome button title with the name xctest in it.")
		XCTAssertEqual(config?.accentColor, Color(red: 1, green: 1, blue: 0))
		XCTAssertEqual(config?.features?.count, 1)
		XCTAssertEqual(config?.features?.first?.title, "Welcome feature title with appname: xctest.")
		XCTAssertEqual(config?.features?.first?.description, "Welcome feature description with version: CFBundleShortVersionString could not be found.")
		XCTAssertEqual(config?.features?.first?.image, Image(systemName: "square.and.arrow.up"))
		XCTAssertEqual(config?.features?.first?.imageColor, Color(red: 1, green: 0, blue: 0))
	}

	func testInitVersionDictionary() {
		let dictionary = defaultVersionDictionary
		WhatsNewVersionRepository.lastKnownVersion = "1.0.0"

		let config = WhatsNewConfiguration(versionDictionary: dictionary)
		XCTAssertEqual(config?.title, "Version 1.1.1 title")
		XCTAssertEqual(config?.description, "Version 1.1.1 description with the version in it: CFBundleShortVersionString could not be found")
		XCTAssertEqual(config?.buttonTitle, "Version 1.1.1 button title with the name xctest in it.")
		XCTAssertEqual(config?.accentColor, Color(red: 1, green: 1, blue: 1))
		XCTAssertEqual(config?.features?.count, 1)
		XCTAssertEqual(config?.features?.first?.title, "Version 1.1.1 feature title with appname: xctest.")
		XCTAssertEqual(config?.features?.first?.description, "Version 1.1.1 feature description with version: CFBundleShortVersionString could not be found.")
		XCTAssertEqual(config?.features?.first?.image, Image(systemName: "square.and.arrow.up"))
		XCTAssertEqual(config?.features?.first?.imageColor, Color(red: 1, green: 0, blue: 0))
	}

	func testInitNoNewVersionDictionary() {
		let dictionary = defaultVersionDictionary
		WhatsNewVersionRepository.lastKnownVersion = "CFBundleShortVersionString could not be found"

		XCTAssertNil(WhatsNewConfiguration(versionDictionary: dictionary))
	}

	func testInitDefaultStringsVersionDictionary() {
		var dictionary = defaultVersionDictionary
		WhatsNewVersionRepository.lastKnownVersion = nil

		var welcomeDictionary = dictionary["Welcome"] as? Dictionary<String, Any>
		welcomeDictionary?.removeValue(forKey: "Title")
		welcomeDictionary?.removeValue(forKey: "AccentTitle")
		welcomeDictionary?.removeValue(forKey: "Description")
		welcomeDictionary?.removeValue(forKey: "ButtonTitle")
		welcomeDictionary?.removeValue(forKey: "AccentColor")
		dictionary["Welcome"] = welcomeDictionary

		let config = WhatsNewConfiguration(versionDictionary: dictionary)
		XCTAssertEqual(config?.title, "Default title")
		XCTAssertEqual(config?.description, "Default description with the version in it: CFBundleShortVersionString could not be found")
		XCTAssertEqual(config?.buttonTitle, "Default button title with the name xctest in it.")
		XCTAssertEqual(config?.accentColor, Color(red: 1, green: 0, blue: 0))
		XCTAssertEqual(config?.features?.count, 1)
		XCTAssertEqual(config?.features?.first?.title, "Welcome feature title with appname: xctest.")
		XCTAssertEqual(config?.features?.first?.description, "Welcome feature description with version: CFBundleShortVersionString could not be found.")
		XCTAssertEqual(config?.features?.first?.image, Image(systemName: "square.and.arrow.up"))
		XCTAssertEqual(config?.features?.first?.imageColor, Color(red: 1, green: 0, blue: 0))
	}

	func testReplacingKeyWords() {
		var config = WhatsNewConfiguration()
		config.title = "This $(AppName) is awesome."
		XCTAssertEqual(config.title, "This xctest is awesome.")

		config.title = "This $(appname) is awesome."
		XCTAssertEqual(config.title, "This xctest is awesome.")

		config.title = "A new Version: $(Version) is available."
		XCTAssertEqual(config.title, "A new Version: CFBundleShortVersionString could not be found is available.")

		config.title = "A new Version: $(vERsIon) is available."
		XCTAssertEqual(config.title, "A new Version: CFBundleShortVersionString could not be found is available.")

		config.accentTitle = "This $(AppName) is awesome."
		XCTAssertEqual(config.accentTitle, "This xctest is awesome.")

		config.description = "This is an awesome $(AppName) description."
		XCTAssertEqual(config.description, "This is an awesome xctest description.")

		config.buttonTitle = "A $(appname) title for a button."
		XCTAssertEqual(config.buttonTitle, "A xctest title for a button.")
	}
}
