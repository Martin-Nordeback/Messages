
// TODO: Searchfield
// TODO:

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    @State private var searchText = ""
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

    var tabTitle: String {
        switch selectedIndex {
        case 0: return "Chats"
        case 1: return "Settings"
        default: return ""
        }
    }
}

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//            .preferredColorScheme(.dark)
//    }
//}
