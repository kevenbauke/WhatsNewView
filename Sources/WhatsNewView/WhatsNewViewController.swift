import SwiftUI

@available(iOS 13.0, *)
public class WhatsNewViewController: UIHostingController<WhatsNewView> {
//	public init?() {
//		guard let path = Bundle.main.path(forResource: "WhatsNewVersion", ofType: "plist") else { return }
//
//		guard let whatsNewView = try? WhatsNewViewController(versionPlistPath: path) else {
//			return nil
//		}
//
//		super.init(rootView: whatsNewView)
//	}

	public init?(versionPlistPath: String) throws {
		do {
			guard let whatsNewView = try WhatsNewView(versionPlistPath: versionPlistPath) else {
				return nil
			}

			super.init(rootView: whatsNewView)
			rootView.hostingController = self
		} catch {
			throw error
		}
	}

	public init(configuration: WhatsNewConfiguration) {
		let whatsNewView = WhatsNewView(configuration: configuration)
		super.init(rootView: whatsNewView)
		rootView.hostingController = self
	}

	public init?(configurationPlistPath: String) throws {
		do {
			guard let whatsNewView = try WhatsNewView(configurationPlistPath: configurationPlistPath) else {
				return nil
			}
			super.init(rootView: whatsNewView)
			rootView.hostingController = self
		} catch {
			throw error
		}
	}

	@objc required dynamic internal init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
