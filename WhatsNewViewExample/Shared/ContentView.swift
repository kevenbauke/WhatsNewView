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

		let feature0 = WhatsNewFeature()

		return features
	}

	private var configuration: WhatsNewConfiguration {
		var configuration = WhatsNewConfiguration()
		configuration.title = "Hello"
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
