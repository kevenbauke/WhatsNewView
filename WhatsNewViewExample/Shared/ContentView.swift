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
//			.sheet(isPresented: $showWhatsNewScreen) {
//				WhatsNewView(configuration: ExampleData.configurationOnly)
//			}

			Button(action: {
				showWhatsNewScreen.toggle()
			}) {
				Text("Plist + Configuration")
					.bold()
			}
			.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .orange))
			.sheet(isPresented: $showWhatsNewScreen) {
				WhatsNewView(plistName: "Content")
			}

			Button(action: {
				showWhatsNewScreen.toggle()
			}) {
				Text("Version Plist")
					.bold()
			}
			.buttonStyle(RoundedRectangleButtonStyle(backgroundColor: .green))
//			.sheet(isPresented: $showWhatsNewScreen) {
//				WhatsNewView(configuration: ExampleData.configurationOnly)
//			}
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
