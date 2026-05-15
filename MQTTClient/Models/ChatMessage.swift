//
//  ChatMessage.swift
//  MQTTClient
//
//  Created by Harish Kumar on 06/05/26.
//

import Foundation

struct ChatMessage: Identifiable, Codable {
    var id = UUID()
    let text: String
    let isIncoming: Bool
    let timestamp: Date
}
