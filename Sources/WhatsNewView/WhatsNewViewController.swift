import SwiftUI

@available(iOS 13.0, *)
public class WhatsNewViewController: UIHostingController<WhatsNewView> {
	public init(configuration: WhatsNewConfiguration) {
		super.init(rootView: WhatsNewView(configuration: configuration))
	}

	@objc required dynamic init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
