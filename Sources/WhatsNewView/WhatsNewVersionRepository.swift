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
		UserDefaults.standard.string(forKey: versionKey) == nil
	}

	static var isNewVersion: Bool {
		if let lastKnownVersion = lastKnownVersion {
			return lastKnownVersion.compare(version) == .orderedAscending
		} else {
			return true
		}
	}

	static func setCurrentVersion() {
		lastKnownVersion = version
	}
}

private extension Bundle {
	var version: String {
		return infoDictionary?["CFBundleShortVersionString"] as! String
	}

	var build: String {
		return infoDictionary?["CFBundleVersion"] as! String
	}
}
