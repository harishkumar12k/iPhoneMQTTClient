//
//  ChatViewModel.swift
//  MQTTClient
//
//  Created by Harish Kumar on 06/05/26.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    
    @Published var messages: [ChatMessage] = []
    @Published var isConnected = false
    @Published var brokerIP: String = "192.168.1.226"
    @Published var yourName: String = "iphone"
    @Published var friendName: String = "mac"
    
    private let mqttService = MQTTService()
    
    init() {
        mqttService.delegate = self
    }
    
    func connect() {
        guard !brokerIP.isEmpty else { return }
        mqttService.connect(host: brokerIP, yourName: yourName, friendName: friendName)
    }
    
    func disconnect() {
        mqttService.disconnect()
    }
    
    func sendMessage(_ text: String) {
        mqttService.send(text, to: friendName)
        
        let message = ChatMessage(
            text: text,
            isIncoming: false,
            timestamp: Date()
        )
        
        messages.append(message)
    }
    
}

extension ChatViewModel: MQTTServiceDelegate {
    
    func didConnect() {
        DispatchQueue.main.async {
            self.isConnected = true
        }
    }
    
    func didDisconnect() {
        DispatchQueue.main.async {
            self.isConnected = false
        }
    }
    
    func didReceiveMessage(_ text: String) {
        DispatchQueue.main.async {
            let message = ChatMessage(
                text: text,
                isIncoming: true,
                timestamp: Date()
            )
            self.messages.append(message)
        }
    }
}
