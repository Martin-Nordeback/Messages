
import SwiftUI

struct LoginView: View {
//    listens to changes in UI 
    @State private var email: String = ""
    @State private var password: String = ""
    
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(HELLO)
                        .font(.largeTitle)
                        .bold()
                    Text("Welcome back")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.orange)
                        .shadow(color: .red, radius: 10, x: 0.0, y: 2.0)
                    

                    VStack(spacing: 32) {
                        LoginTextFieldsView(
                            imageName: "mail",
                            placeHolderText: "Email",
                            isSecureTextField: false,
                            text: $email)
                        LoginTextFieldsView(
                            imageName: "key.horizontal",
                            placeHolderText: "Password...",
                            isSecureTextField: true,
                            text: $password)
                    }
                    .padding(.horizontal, 32)
                    .padding(.top, 32)
                    .shadow(color: .red, radius: 10, x: 0.0, y: 2.0)
                }
                .padding(.leading)

                HStack {
                    Spacer()
                    NavigationLink {
                        Text("code for forgot password here")
                    } label: {
                        Text("Forgot password?")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.green)
                            .padding(.top)
                            .padding(.trailing, 20)
                    }
                }
//                calls the login function inside AuthViewModel
                Button {
                    viewModel.login(withEmail: email, password: password)
                } label: {
                    Text("Sign in")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 240, height: 50)
                        .background(.orange)
                        .clipShape(Capsule())
                        .padding()
                }
                .shadow(color: .red, radius: 10, x: 0.0, y: 0.0)

                Spacer()

                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack {
                        Text("Don't have an account yet?")
                            .font(.system(size: 14))
                        Text("Sign Up here!")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundColor(.green)
                }
            }
            .padding([.top, .bottom])
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
    }
}
