import SwiftUI

@available(iOS 13.0, *)
struct LeftAligned: ViewModifier {
	func body(content: Content) -> some View {
		HStack {
			content
			Spacer()
		}
	}
}

@available(iOS 13.0, *)
extension View {
	func leftAligned() -> some View {
		return self.modifier(LeftAligned())
	}
}

extension Bundle {
	var displayName: String? {
		return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
	}
}
