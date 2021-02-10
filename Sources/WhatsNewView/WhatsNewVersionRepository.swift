import Foundation

struct WhatsNewVersionRepository {
	static private let versionKey = "WhatsNextVersion"

	static var lastKnownVersion: String? {
		set {
			UserDefaults.standard.setValue(newValue, forKey: versionKey)
		}
		get {
			UserDefaults.standard.string(forKey: versionKey) ?? nil
		}
	}

	static var version: String {
		Bundle.main.version
	}

	static var isInitialStart: Bool {
		UserDefaults.standard.string(forKey: versionKey).isEmptyOrNil
	}

	static var isNewVersion: Bool {
		switch lastKnownVersion?.compare(version) {
		case .orderedAscending:
			return true
		default:
			return false
		}
	}

	static func setCurrentVersion() {
		lastKnownVersion = version
	}
}

private extension Bundle {
	var version: String {
		infoDictionary?["CFBundleShortVersionString"] as! String
	}

	var build: String {
		infoDictionary?["CFBundleVersion"] as! String
	}
}
