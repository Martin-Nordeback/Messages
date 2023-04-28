import SwiftUI
/*
 Display the user you logged in to, at a later version you will be able to edit your profile photo and more
 */
struct SettingHeaderView: View {
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        HStack {
            Image("dummypic")
                .resizable()
                .scaledToFill()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
                .padding(.leading)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.fullname)
                    .font(.system(size: 18)).bold()
                    .foregroundColor(.white)
                
                Text("Available")
                    .foregroundColor(.white)
                    .font(.system(size: 14))
            }
    
            Spacer()
        }
        .frame(height: 80)

    }
}
