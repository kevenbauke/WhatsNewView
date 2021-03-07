import SwiftUI

@available(iOS 13.0, *)
public class WhatsNewViewController: UIHostingController<WhatsNewView> {

	public var whatsNewView: WhatsNewView

	public init?(versionPlistPath: String) throws {
		do {
			guard let whatsNewView = try WhatsNewView(versionPlistPath: versionPlistPath) else {
				return nil
			}

			self.whatsNewView = whatsNewView
			super.init(rootView: whatsNewView)
		} catch {
			throw error
		}
	}

	public init(configuration: WhatsNewConfiguration) {
		whatsNewView = WhatsNewView(configuration: configuration)
		super.init(rootView: whatsNewView)
		whatsNewView.delegate = self
	}

	public init?(configurationPlistPath: String) throws {
		do {
			guard let whatsNewView = try WhatsNewView(configurationPlistPath: configurationPlistPath) else {
				return nil
			}
			self.whatsNewView = whatsNewView
			super.init(rootView: whatsNewView)
			self.whatsNewView.delegate = self
		} catch {
			throw error
		}
	}

	@objc required dynamic internal init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func viewDidLoad() {
		whatsNewView.delegate = self
	}
}

@available(iOS 13.0, *)
extension WhatsNewViewController: WhatsNewViewDelegate {
	public func whatsNewViewDidDismiss(_ whatsnewView: WhatsNewView) {
		self.dismiss(animated: true)
	}
}
