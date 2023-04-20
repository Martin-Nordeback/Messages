//
//  LoginTextFieldsView.swift
//  ChatAppSwiftUI
//
//  Created by Martin Nordebäck on 2023-04-12.
//

import SwiftUI

struct LoginTextFieldsView: View {
    let imageName: String
    let placeHolderText: String
    let isSecureTextField: Bool

    @Binding var text: String

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.orange)

                if isSecureTextField {
                    SecureField(placeHolderText, text: $text)

                } else {
                    TextField(placeHolderText, text: $text)
                }
            }
        
            Divider()
                .background(Color(.darkGray))
        }
    }
}
