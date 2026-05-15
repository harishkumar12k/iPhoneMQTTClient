//
//  MessageInputView.swift
//  MQTTClient
//
//  Created by Harish Kumar on 06/05/26.
//

import SwiftUI

struct MessageInputView: View {
    
    @Binding var text: String
    var onSend: () -> Void
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            TextField("Message...", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .focused($isFocused)
            
            Button(action: {
                onSend()
                isFocused = true
            }) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(text.isEmpty ? Color.gray : Color.blue)
                    .clipShape(Circle())
            }
            .disabled(text.isEmpty)
        }
        .padding()
    }
}
