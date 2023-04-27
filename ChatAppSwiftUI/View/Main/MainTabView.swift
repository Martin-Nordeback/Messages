
// TODO: Searchfield
// TODO:

// Main view after user is authenticated,

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    @State private var searchText = ""
//    lissens to changes inside the UI
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        if let user = viewModel.currentUser {
            NavigationStack {
                TabView(selection: $selectedIndex) {
                    ConversationsView()
                        .onTapGesture {
                            selectedIndex = 0
                        }
                        .tabItem {
                            Image(systemName: "bubble.left")
                                .foregroundColor(Color.accentColor)
                        }
                        .tag(0)

                    SettingsView(user: user)
                        .onTapGesture {
                            selectedIndex = 1
                        }
                        .tabItem {
                            Image(systemName: "gear")
                        }
                        .tag(1)
                }

                .navigationTitle(tabTitle)
            }
            .searchable(text: $searchText)

        } else {
            ///
        }
    }

//    computedproperty to display correct title of the users selected tab
    var tabTitle: String {
        switch selectedIndex {
        case 0: return "Chats"
        case 1: return "Settings"
        default: return ""
        }
    }
}
