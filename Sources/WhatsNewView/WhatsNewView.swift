import SwiftUI

let margin: CGFloat = 40
let listMargin: CGFloat = 25

@available(iOS 13, *)
public protocol WhatsNewViewDelegate: AnyObject {
	/// Called whenever the action button was tapped.
	/// - Parameter whatsnewView: The WhatsNewView in which the action occured.
	func whatsNewViewDidTapActionButton(_ whatsnewView: WhatsNewView)

	/// Called whenever the view got dismissed.
	/// - Parameter whatsnewView: The WhatsNewView in which the action occured.
	func whatsNewViewDidDismiss(_ whatsnewView: WhatsNewView)
}

@available(iOS 13, *)
extension WhatsNewViewDelegate {
	public func whatsNewViewDidTapActionButton(_ whatsnewView: WhatsNewView) {}
	public func whatsNewViewDidDismiss(_ whatsnewView: WhatsNewView) {}
}

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
/// The main view showing the title, description features and a button. The content comes from the configuration file.
public struct WhatsNewView: View, Identifiable {
	/// All possible errors that can occur initializing this view.
	public enum InitError: LocalizedError {
		case couldNotFindPathToVersionFile
		case configurationDictionaryMalformed
		case couldNotFindConfigurationFile(path: String)

		public var errorDescription: String? {
			switch self {
			case .couldNotFindPathToVersionFile:
				return "The WhatsNewVersion.plist could not be found in the the main bundle. Did you add it to the project?"
			case .couldNotFindConfigurationFile(let path):
				return "The configuration file could not be found at path: \(path)."
			case .configurationDictionaryMalformed:
				return "The WhatsNewVersion.plist file seems to be malformed. Check if all the right types are set in the plist-File."
			}
		}
	}

	/// A unique id to differentiate the different instances and to conform to Identifiable.
	public let id = UUID()

	/// The configuration file which holds all the information needed to fill this view with content.
	public var configuration: WhatsNewConfiguration?

	/// A delegate to communicate changes to the receiver.
	public weak var delegate: WhatsNewViewDelegate?

	/// A hosting controller used to configure the view with UIKit.
	internal var hostingController: WhatsNewViewController?

	/// The general space of this view from its superview.
	private let margin: CGFloat = 40

	/// The space of the list from its superview.
	private let listMargin: CGFloat = 25

	/// The env variable that represents the presentation mode. Needed to dismiss this view when the button was tapped.
	@Environment(\.presentationMode) private var presentationMode

	/// The content of the view.
	public var body: some View {
		VStack(spacing: 8) {
			Group {
				if let title = configuration?.title {
					if let accentTitle = configuration?.accentTitle {
						Text(title)
							.bold()
						+
						Text(" " + accentTitle)
							.bold()
							.foregroundColor(configuration?.accentColor ?? .accentColor)
					} else {
						Text(title)
							.bold()
					}
				} else {
					if let accentTitle = configuration?.accentTitle {
						Text(accentTitle)
							.bold()
							.foregroundColor(configuration?.accentColor ?? .accentColor)
					}
				}
			}
			.fixedSize(horizontal: false, vertical: true)
			.leftAligned()
			.font(Font.system(size: 40))

			Group {
				if let description = configuration?.description {
					Text(description)
				}
			}
			.leftAligned()
		}
		.padding(EdgeInsets(top: margin, leading: margin, bottom: margin/2, trailing: margin))

		if let features = configuration?.features {
			List(features) { feature in
				WhatsNewFeatureView(feature: feature)
			}
			.padding(EdgeInsets(top: 0, leading: listMargin, bottom: 0, trailing: listMargin))
		}

		Button(action: {
			if let action = configuration?.buttonAction {
				action()
			}
			delegate?.whatsNewViewDidTapActionButton(self)
			dismiss()
		}) {
			Group {
				if let buttonTitle = configuration?.buttonTitle {
					Text(buttonTitle)
						.bold()
				}
			}
		}
		.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: configuration?.accentColor ?? Color.accentColor))
		.padding(EdgeInsets(top: margin/2, leading: margin, bottom: margin/2, trailing: margin))
		.onDisappear {
			if let dismissAction = configuration?.dismissAction {
				dismissAction()
			}
			dismiss()
		}
	}

	/// The default init of this class. It automatically searches for the WhatsNewVersion.plist file and configures the configuration file.
	/// - Remark: The WhatsNewVersion.plisy file has to be placed in the main bundle for this initializer to work.
	/// - Throws: InitErrors. Each of these errors have a helpful `errorDescription`.
	public init?() throws {
		if let path = Bundle.main.path(forResource: "WhatsNewVersion", ofType: "plist") {
			if let versionDictionary = NSDictionary(contentsOfFile: path) as? Dictionary<String, Any> {
				if let configuration = WhatsNewConfiguration(versionDictionary: versionDictionary) {
					self.configuration = configuration
				} else {
					return nil
				}
			} else {
				throw InitError.configurationDictionaryMalformed
			}
		} else {
			throw InitError.couldNotFindPathToVersionFile
		}
	}

	/// An initializer to init the class with a custom path to the version plist file.
	/// - Parameter versionPlistPath: The path pointing to the version plist file.
	/// - Throws: InitErrors. Each of these errors have a helpful `errorDescription`.
	public init?(versionPlistPath: String) throws {
		guard FileManager().fileExists(atPath: versionPlistPath) else {
			throw InitError.couldNotFindConfigurationFile(path: versionPlistPath)
		}

		if let versionDictionary = NSDictionary(contentsOfFile: versionPlistPath) as? Dictionary<String, Any> {
			if let configuration = WhatsNewConfiguration(versionDictionary: versionDictionary) {
				self.configuration = configuration
			} else {
				return nil
			}
		} else {
			throw InitError.configurationDictionaryMalformed
		}
	}

	/// This initializer is used in case the view should be managed by code.
	/// - Parameter configuration: The configuration of this view. See `WhatsNewConfiguration` for more details.
	public init(configuration: WhatsNewConfiguration) {
		self.configuration = configuration
	}

	/// An initializer to setup this view with a configuration plist file.
	/// - Parameter configurationPlistPath: The path to the configuration plist file.
	/// - Throws: InitErrors. Each of these errors have a helpful `errorDescription`.
	public init?(configurationPlistPath: String) throws {
		guard FileManager().fileExists(atPath: configurationPlistPath) else {
			throw InitError.couldNotFindConfigurationFile(path: configurationPlistPath)
		}

		if let configurationDictionary = NSDictionary(contentsOfFile: configurationPlistPath) as? Dictionary<String, Any> {
			configuration = WhatsNewConfiguration(dictionary: configurationDictionary)
		} else {
			throw InitError.configurationDictionaryMalformed
		}
	}

	/// A debug function to delete the version saved in the framework.
	public static func resetVersion() {
		WhatsNewVersionRepository.lastKnownVersion = nil
	}

	/// A debug function to manually set a specific version the framework should use as last known.
	/// - Parameter version: The version to be saved. The string should follow the semantic versioning scheme: `https://semver.org`, e.g. 1.0.2.
	public static func setLastKnownVersion(_ version: String?) {
		WhatsNewVersionRepository.lastKnownVersion = version
	}

	private func dismiss() {
		hostingController?.dismiss(animated: true)
		delegate?.whatsNewViewDidDismiss(self)
		WhatsNewVersionRepository.setCurrentVersion()
	}
}

@available(macOS 11, iOS 13, watchOS 6, tvOS 13, *)
private struct RoundedRectangleButtonStyle: ButtonStyle {
	var backgroundColor: Color

  func makeBody(configuration: Configuration) -> some View {
	HStack {
	  configuration.label
		.frame(minWidth: 0, maxWidth: .infinity)
		.padding()
		.foregroundColor(.white)
		.background(backgroundColor)
		.cornerRadius(10)
	}
	.scaleEffect(configuration.isPressed ? 0.97 : 1)
	.animation(.easeOut)
  }
}
