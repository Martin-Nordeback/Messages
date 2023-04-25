
import SwiftUI

struct ContentView: View {
    //declared in @main, and it's used to inject the AuthViewModel, so we can access its properties
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        //Group render to different views depend of if the user is logged in or not
        Group {
            if viewModel.userSession != nil {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
