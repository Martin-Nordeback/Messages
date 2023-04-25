

import SwiftUI

struct SettingsView: View {
    private let user: User

    init(user: User) {
        self.user = user
    }

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            Button {
                AuthViewModel.shared.signout()
            } label: {
                Text("Log Out")
                    .foregroundColor(.red)
                    .font(.system(size: 16, weight: .semibold))
                    .frame(width: UIScreen.main.bounds.width, height: 50)
                    .background(Color.secondary)
            }

            Spacer()
        }
    }
}

