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

	private var configuration: WhatsNewConfiguration {
		var configuration = WhatsNewConfiguration()
		configuration.title = "Welcome to"
		configuration.accentedTitle = "My App"
		configuration.description = "Some awesome description"
		configuration.accentColor = .purple

		configuration.features = features
		configuration.buttonTitle = "OK"
		configuration.buttonAction = {
			print("Button tapped.")
		}

		return configuration
	}

	var body: some View {
		Text("Main Content View")
			.font(.largeTitle)
			.padding()
		Button("Show Sheet", action: {
			showWhatsNewScreen.toggle()
		})
		.sheet(isPresented: $showWhatsNewScreen) {
			WhatsNewView(configuration: configuration)
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ContentView()
    }
}
