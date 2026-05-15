//
//  ChatView.swift
//  MQTTClient
//
//  Created by Harish Kumar on 06/05/26.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject var viewModel: ChatViewModel
    @State private var inputText = ""
    
    var body: some View {
        VStack {
            ConnectionControlView(
                ipAddress: $viewModel.brokerIP,
                yourName: $viewModel.yourName,
                friendName: $viewModel.friendName,
                isConnected: viewModel.isConnected,
                onConnect: {
                    viewModel.connect()
                },
                onDisconnect: {
                    viewModel.disconnect()
                }
            )
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(viewModel.messages) { message in
                            ChatBubbleView(message: message)
                                .id(message.id)
                        }
                    }
                }
                .hideKeyboardOnTap()
                .onChange(of: viewModel.messages.count) {
                    scrollToBottom(proxy)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        scrollToBottom(proxy)
                    }
                }
            }
            MessageInputView(
                text: $inputText,
                onSend: {
                    viewModel.sendMessage(inputText)
                    inputText = ""
                }
            )
        }
    }
    
    func scrollToBottom(_ proxy: ScrollViewProxy) {
        if let last = viewModel.messages.last {
            proxy.scrollTo(last.id, anchor: .bottom)
        }
    }
    
}
