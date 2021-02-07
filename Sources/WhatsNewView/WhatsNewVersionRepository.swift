import Foundation

struct WhatsNewVersionRepository {
	private let wasShownKey = "WhatsNextWasShown"
	private let versionKey = "WhatsNextVersion"

	private var lastKnownVersion: String? {
		UserDefaults.standard.string(forKey: versionKey) ?? "0.0"
	}

	var version: String {
		Bundle.main.version
	}

	var isInitialStart: Bool {
		UserDefaults.standard.bool(forKey: wasShownKey)
	}

	var isNewVersion: Bool {
		if let lastKnownVersion = lastKnownVersion {
			return lastKnownVersion.compare(version) == .orderedAscending
		} else {
			return true
		}
	}

	func setVersion(_ version: String) {
		UserDefaults.standard.setValue(version, forKey: versionKey)
	}
	
	func setLastKnownVersion() {
		UserDefaults.standard.setValue(version, forKey: versionKey)
		UserDefaults.standard.setValue(true, forKey: wasShownKey)
	}

	func resetVersion() {
		UserDefaults.standard.setValue(nil, forKey: versionKey)
	}
}
