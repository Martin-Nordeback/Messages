//
//  RegistrationView.swift
//  ChatAppSwiftUI
//
//  Created by Martin Nordebäck on 2023-04-12.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email: String = ""
    @State private var userName: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""

    @Environment(\.presentationMode) var mode

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 6) {
                Text("Hell yeah!!")
                    .font(.largeTitle)
                    .bold()
                Text("What are you waiting for?")
                    .font(.title)
                    .bold()
                    .foregroundColor(.orange)
                    .shadow(color: .red, radius: 10, x: 0.0, y: 2.0)

                VStack(spacing: 22) {
                    LoginTextFieldsView(
                        imageName: "envelope",
                        placeHolderText: "Email",
                        isSecureTextField: false,
                        text: $email)
                    LoginTextFieldsView(
                        imageName: "lock",
                        placeHolderText: "Sir Name",
                        isSecureTextField: false,
                        text: $userName)
                    LoginTextFieldsView(
                        imageName: "lock",
                        placeHolderText: "Last Name",
                        isSecureTextField: false,
                        text: $fullName)
                    LoginTextFieldsView(
                        imageName: "lock",
                        placeHolderText: "Password",
                        isSecureTextField: true,
                        text: $password)
                }
                .padding(.horizontal, 22)
                .padding(.top)
            }
            .padding([.leading])

            Button {
                print("Sign up code here")
            } label: {
                Text("Sign up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 240, height: 50)
                    .background(.orange)
                    .clipShape(Capsule())
                    .padding()
            }
            .shadow(color: .red, radius: 10, x: 0.0, y: 0.0)

            Spacer()

            Button {
                mode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Text("Already have an account?")
                        .font(.system(size: 14))
                    Text("Sign in here!")
                        .font(.system(size: 14)).bold()
                }
                .foregroundColor(Color.green)
                .shadow(color: .green, radius: 10, x: 0.0, y: 0.0)
            }
            .padding(.bottom, 32)
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
            .preferredColorScheme(.dark)
    }
}
