//
//  WhatsNewViewExampleApp.swift
//  Shared
//
//  Created by Keven Bauke on 06.02.21.
//

import SwiftUI
import WhatsNewView

@main
struct WhatsNewViewExampleApp: App {
	@State var whatsNewView: WhatsNewView?

    var body: some Scene {
        WindowGroup {
            ContentView()
				.sheet(item: $whatsNewView) { item -> WhatsNewView? in
					whatsNewView
				}
				.onAppear {
					if let path = Bundle.main.path(forResource: "WhatsNewVersion", ofType: "plist") {
					   whatsNewView = WhatsNewView(versionPlistPath: path)
					}
				}
        }
    }
}
