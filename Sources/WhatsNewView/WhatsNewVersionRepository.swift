import Foundation

struct WhatsNewVersionRepository {
	private let userDefaultsName = "WhatsNextUserDefaults"
	private let wasShownKey = "WhatsNextWasShown"
	private let versionKey = "WhatsNextVersion"

	private var userDefaults: UserDefaults {
		let userDefaults = UserDefaults(suiteName: userDefaultsName) ?? UserDefaults.standard
		return userDefaults
	}

	private var lastKnownVersion: String? {
		userDefaults.string(forKey: versionKey) ?? "0.0"
	}

	var version: String {
		Bundle.main.version
	}

	var isInitialStart: Bool {
		return userDefaults.bool(forKey: wasShownKey)
	}

	var isNewVersion: Bool {
		if let lastKnownVersion = lastKnownVersion {
			return lastKnownVersion.compare(version) == .orderedAscending
		} else {
			return true
		}
	}
	
	func setLastKnownVersion() {
		userDefaults.setValue(version, forKey: versionKey)
		userDefaults.setValue(true, forKey: wasShownKey)
	}
}
