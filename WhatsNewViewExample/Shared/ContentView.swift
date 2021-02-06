//
//  ContentView.swift
//  Shared
//
//  Created by Keven Bauke on 06.02.21.
//

import SwiftUI
import WhatsNewView

struct ContentView: View {
	@State private var showWhatsNewScreen = false

	private var features: [WhatsNewFeature] {
		var features = [WhatsNewFeature]()

		features.append(WhatsNewFeature(image: Image(systemName: "figure.wave"),
										imageColor: .red,
										title: "A welcome screen",
										description: "Welcome your users and introduce important functionality."))
		features.append(WhatsNewFeature(image: Image(systemName: "megaphone.fill"),
										imageColor: .orange,
										title: "A new version screen",
										description: "Introduce your users to great new features in new versions."))
		features.append(WhatsNewFeature(image: Image(systemName: "text.book.closed.fill"),
										imageColor: .green,
										title: "A simple how to screen",
										description: "Help your users and explain a screen or a feature."))

		return features
	}

	private var configurationOnly: WhatsNewConfiguration {
		var configuration = WhatsNewConfiguration()
		configuration.title = "Welcome to"
		configuration.accentedTitle = "WhatsNewView"
		configuration.description = "This view can help you give that extra information your user needs at certain points in your app."
		configuration.accentColor = .purple

		configuration.features = features
		configuration.buttonTitle = "OK"
		configuration.buttonAction = {
			print("Button tapped.")
		}

		return configuration
	}

	var body: some View {
		Text("WhatsNewView Example")
			.font(.largeTitle)
			.padding()

		VStack(spacing: 8) {
			Button(action: {
				showWhatsNewScreen.toggle()
			}) {
				Text("Configuration (Code only)")
					.bold()
			}
			.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .red))
			.sheet(isPresented: $showWhatsNewScreen) {
				WhatsNewView(configuration: configurationOnly)
			}

			Button(action: {
				showWhatsNewScreen.toggle()
			}) {
				Text("Plist + Configuration")
					.bold()
			}
			.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .orange))
			.sheet(isPresented: $showWhatsNewScreen) {
				WhatsNewView(configuration: configurationOnly)
			}

			Button(action: {
				showWhatsNewScreen.toggle()
			}) {
				Text("Version Plist")
					.bold()
			}
			.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .green))
			.sheet(isPresented: $showWhatsNewScreen) {
				WhatsNewView(configuration: configurationOnly)
			}
		}
	}
}

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
	.padding(.horizontal)
	.scaleEffect(configuration.isPressed ? 0.97 : 1)
	.animation(.easeOut)
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
