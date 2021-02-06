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

	private var configuration: WhatsNewConfiguration {
		var configuration = WhatsNewConfiguration()
		configuration.accentColor = .purple
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
