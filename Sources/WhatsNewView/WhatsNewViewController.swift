import SwiftUI

@available(iOS 13.0, *)
public class WhatsNewViewController: UIHostingController<WhatsNewView> {
	public init?(versionPlistPath: String) throws {
		do {
			guard var whatsNewView = try WhatsNewView(versionPlistPath: versionPlistPath) else {
				return nil
			}
			
			super.init(rootView: whatsNewView)
			whatsNewView.delegate = self
		} catch {
			throw error
		}
	}

	public init(configuration: WhatsNewConfiguration) {
		super.init(rootView: WhatsNewView(configuration: configuration))
	}

	public init?(configurationPlistPath: String) throws {
		do {
			guard let whatsNewView = try WhatsNewView(configurationPlistPath: configurationPlistPath) else {
				return nil
			}
			super.init(rootView: whatsNewView)
		} catch {
			throw error
		}
	}

	@objc required dynamic internal init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

@available(iOS 13.0, *)
extension WhatsNewViewController: WhatsNewViewDelegate {
	public func whatsNewViewDidTapActionButton(_ whatsnewView: WhatsNewView) {}

	public func whatsNewViewDidDismiss(_ whatsnewView: WhatsNewView) {
		self.dismiss(animated: true)
	}
}
