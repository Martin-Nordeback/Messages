
//TODO: Searchfield
//TODO:

import SwiftUI

struct MainTabView: View {
    @State private var selectedIndex = 0
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            TabView(selection: $selectedIndex) {
                ConversationsView()
                    .onTapGesture {
                        selectedIndex = 0
                    }
                    .tabItem {
                        Image(systemName: "bubble.left")}
                    .tag(0)

                SettingsView()
                    .onTapGesture {
                        selectedIndex = 1
                    }
                    .tabItem {
                        Image(systemName: "gear")}
                    .tag(1)
            }
            .navigationTitle(tabTitle)
        }
        .searchable(text: $searchText)
    }

    var tabTitle: String {
        switch selectedIndex {
        case 0: return "Chats"
        case 1: return "Settings"
        default: return ""
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .preferredColorScheme(.dark)
    }
}
