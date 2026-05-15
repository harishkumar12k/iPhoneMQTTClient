//
//  ChatBubbleView.swift
//  MQTTClient
//
//  Created by Harish Kumar on 06/05/26.
//

import SwiftUI

struct ChatBubbleView: View {
    
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isIncoming {
                bubble(color: .gray.opacity(0.2), textColor: .black)
                Spacer()
            } else {
                Spacer()
                bubble(color: .green, textColor: .white)
            }
        }
        .padding(.horizontal)
    }
    
    func bubble(color: Color, textColor: Color) -> some View {
        Text(message.text)
            .padding()
            .background(color)
            .foregroundColor(textColor)
            .cornerRadius(16)
    }
}
