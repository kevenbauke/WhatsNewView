import Foundation

/// A class that handles the versioning within the framework.
struct WhatsNewVersionRepository {
	static private let versionKey = "WhatsNextVersion"

	/// Stores the last known bundle version into the standard UserDefaults.
	static var lastKnownVersion: String? {
		set {
			UserDefaults.standard.setValue(newValue, forKey: versionKey)
		}
		get {
			UserDefaults.standard.string(forKey: versionKey) ?? nil
		}
	}

	/// Saves the current bundle version as the last known version.
	static func setCurrentVersion() {
		lastKnownVersion = bundleVersion
	}

	/// Returns whether a previous version was set or not. A missing version indicates the view was never presented before.
	static var isInitialStart: Bool {
		UserDefaults.standard.string(forKey: versionKey).isEmptyOrNil
	}

	/// Checks whether the bundle version is newer than the previously saved one.
	static var isNewVersion: Bool {
		if let lastKnownVersion = lastKnownVersion {
			return lastKnownVersion.compare(bundleVersion) == .orderedAscending
		} else {
			return true
		}
	}

	/// Returns the current version of the bundle.
	static var bundleVersion: String {
		Bundle.main.version ?? "CFBundleShortVersionString could not be found"
	}
}

private extension Bundle {
	var version: String? {
		infoDictionary?["CFBundleShortVersionString"] as? String
	}
}
