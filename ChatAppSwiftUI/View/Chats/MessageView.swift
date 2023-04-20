//
//  MessageView.swift
//  ChatAppSwiftUI
//
//  Created by Martin Nordebäck on 2023-04-20.
//

import SwiftUI

struct MessageView: View {
    var isFromCurrentUser: Bool
    var messageText: String

    var body: some View {
        HStack {
            if isFromCurrentUser {
                Spacer()
                Text(messageText)
                    .padding(12)
                    .background(Color.orange)
                    .font(.system(size: 15))
                    .clipShape(ChatBubbleShape(isFromCurrentUser: true))
                    .foregroundColor(.white)
                    .padding(.leading, 100)
                    .padding(.horizontal)

            } else {
                HStack(alignment: .bottom) {
                    Image("sun.min")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())

                    Text(messageText)
                        .padding(12)
                        .background(.gray)
                        .font(.system(size: 15))
                        .clipShape(ChatBubbleShape(isFromCurrentUser: false))
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                //because the profile image
                .padding(.trailing, 80)
                Spacer()
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(isFromCurrentUser: false, messageText: "Hello Gray bubble with profile image")
//        MessageView(isFromCurrentUser: true, messageText: "Hello blu bubble without profile image")
            .preferredColorScheme(.dark)
    }
}
