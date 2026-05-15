//
//  ConnectionControlView.swift
//  MQTTClient
//
//  Created by Harish Kumar on 06/05/26.
//

import SwiftUI

struct ConnectionControlView: View {
    
    @Binding var ipAddress: String
    @Binding var yourName: String
    @Binding var friendName: String
    let isConnected: Bool
    let onConnect: () -> Void
    let onDisconnect: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                TextField("Your Name", text: $yourName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(isConnected)
                TextField("Friend Name", text: $friendName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(isConnected)
            }
            HStack {
                TextField("Broker IP (e.g. 192.168.1.226)", text: $ipAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                
                Button(action: {
                    if !ipAddress.isEmpty {
                        isConnected ? onDisconnect() : onConnect()
                    }
                }) {
                    Text(isConnected ? "Disconnect" : "Connect")
                        .bold()
                        .frame(width: 100, height: 40)
                        .background(isConnected ? Color.red : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .disabled(isConnected)
                }
            }
        }
        .padding()
    }
}
