
import SwiftUI

struct RegistrationView: View {
    
    //    listens to changes in UI
    @State private var email: String = ""
    @State private var userName: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""

    // so we can dismiss the current view
    @Environment(\.presentationMode) var mode
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        VStack {
            NavigationLink(
                destination: MainTabView(),
                isActive: $viewModel.didAuthenticateUser,
                label: {})

            VStack(alignment: .leading, spacing: 6) {
                Text("Get started.")
                    .font(.largeTitle)
                    .bold()
                Text("Create your account.")
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
                        placeHolderText: "Username",
                        isSecureTextField: false,
                        text: $userName)
                    LoginTextFieldsView(
                        imageName: "lock",
                        placeHolderText: "Fullname",
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
//                calls the register function inside AuthViewModel
            Button {
                viewModel.register(withEmail: email, password: password, fullname: fullName, username: userName)
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
            .padding(.top, 26)

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
