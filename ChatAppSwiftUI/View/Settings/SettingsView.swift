// TODO: Start setting up this page.

/*
 Functionality to EditProfileView SettingHeaderView, next update
 */

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

            VStack(spacing: 32) {
                NavigationLink(
                    destination: EditProfileView(user: user),
                    label: { SettingHeaderView(user: user) })

                VStack(spacing: 1) {
                    ForEach(SettingsCellViewModel.allCases, id: \.self) { viewModel in
                        SettingsCell(viewModel: viewModel)
                    }
                }

                // signout both from app and firestore
                Button {
                    AuthViewModel.shared.signout()
                } label: {
                    Text("Sign out")
                        .foregroundColor(.red)
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: UIScreen.main.bounds.width, height: 50)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }

                Spacer()
            }
        }
    }
}
