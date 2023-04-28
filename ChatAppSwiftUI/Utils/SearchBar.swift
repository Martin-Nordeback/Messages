//
//  SearchBar.swift
//  ChatAppSwiftUI
//
//  Created by Martin Nordebäck on 2023-04-28.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    @State private var animationAmount = 1.0

    var body: some View {
        HStack {
            TextField("Search users", text: $text, onEditingChanged: { editing in
                isEditing = editing
            })
            .padding(8)
            .padding(.horizontal, 24)
            .background(Color(.systemGray2))
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 8)

                    if isEditing {
                        Button(action: {
                            text = ""
                        }, label: {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        })
                    }
                }
            )
            .padding(.horizontal, 8)
            .onTapGesture {
                isEditing = true
            }

            if isEditing {
                Button(action: {
                    isEditing = false
                    text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Cancel")
                })
                .transition(.move(edge: .trailing))
                .animation(.default, value: animationAmount)
                
            }
        }
        .padding(.horizontal)
    }
}

//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}
