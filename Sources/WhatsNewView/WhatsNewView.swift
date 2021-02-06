import SwiftUI

let margin: CGFloat = 40
let listMargin: CGFloat = 25

@available(iOS 13.0.0, *)
public struct WhatsNewView: View {
	let margin: CGFloat = 40
	let listMargin: CGFloat = 25

	public var body: some View {
		VStack(spacing: 8) {
			Group {
				Text("Welcome to ")
					.bold()
					+
					Text("WhatsNewView")
					.bold()
					.foregroundColor(.accentColor)
			}
			.fixedSize(horizontal: false, vertical: true)
			.leftAligned()
			.font(.largeTitle)

			Text("This view can help you to give that extra information your user needs at certain points in your app.")
				.leftAligned()
		}
		.padding(EdgeInsets(top: margin, leading: margin, bottom: margin/2, trailing: margin))

		List {
			ListItemView(image: Image(systemName: "figure.wave"),
						 imageColor: Color.red,
						 headlineText: Text("A welcome screen"),
						 bodyText: Text("Welcome your users and introduce elementary  functionality."))
			ListItemView(image: Image(systemName: "megaphone.fill"),
						 imageColor: Color.orange,
						 headlineText: Text("A new version screen"),
						 bodyText: Text("Introduce your users to great new features in new versions."))
			ListItemView(image: Image(systemName: "text.book.closed.fill"),
						 imageColor: Color.green,
						 headlineText: Text("A simple how to screen"),
						 bodyText: Text("Help your users and explain a screen or a feature to the users."))
		}
		.padding(EdgeInsets(top: 0, leading: listMargin, bottom: 0, trailing: listMargin))

		Button(action: {
			print("Menu Button Tapped")
		}) {
			Text("Got it!")
				.bold()
				.frame(minWidth: 0, maxWidth: .infinity)
				.padding()
				.foregroundColor(.white)
				.background(Color.accentColor)
				.cornerRadius(10)
		}
		.padding(EdgeInsets(top: margin/2, leading: margin, bottom: margin/2, trailing: margin))
	}
}

@available(iOS 13.0, *)
private struct ListItemView: View {
	let image: Image?
	let imageColor: Color?
	let headlineText: Text?
	let bodyText: Text

	init(image: Image? = nil, imageColor: Color? = .black, headlineText: Text? = nil, bodyText: Text) {
		self.image = image
		self.imageColor = imageColor
		self.headlineText = headlineText
		self.bodyText = bodyText
	}

	var body: some View {
		HStack {
			image?
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 50, height: 50)
				.padding(.trailing)
				.foregroundColor(imageColor ?? Color.black)

			VStack(spacing: 4) {
				headlineText?
					.font(.headline)
					.leftAligned()
				bodyText
					.leftAligned()
			}
		}
		.padding(.vertical)
	}
}

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

struct WhatsNewView_Previews: PreviewProvider {
	@available(iOS 13.0, *)
	static var previews: some View {
		Group {
			WhatsNewView()
		}
	}
}
