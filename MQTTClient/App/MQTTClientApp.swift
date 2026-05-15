//
//  MQTTClientApp.swift
//  MQTTClient
//
//  Created by Harish Kumar on 30/04/26.
//

import SwiftUI

@main
struct MQTTClientApp: App {
    var body: some Scene {
        WindowGroup {
            ChatView(viewModel: ChatViewModel())
        }
    }
}
