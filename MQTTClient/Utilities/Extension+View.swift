//
//  Extension+View.swift
//  MQTTClient
//
//  Created by Harish Kumar on 06/05/26.
//

import SwiftUI

extension View {
    func hideKeyboardOnTap() -> some View {
        self
            .contentShape(Rectangle())
            .simultaneousGesture(
                TapGesture().onEnded {
                    UIApplication.shared.sendAction(
                        #selector(UIResponder.resignFirstResponder),
                        to: nil,
                        from: nil,
                        for: nil
                    )
                }
            )
    }
}
