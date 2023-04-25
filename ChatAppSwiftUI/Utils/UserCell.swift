
//TODO: Generate a profile picture
//TODO:

import SwiftUI

//rep the user in the newMessageView
struct UserCell: View {
    let user: User
    var body: some View {
        VStack {
            HStack {
                // change default picutre
                Image("dummypic")


                VStack(alignment: .leading, spacing: 4) {
                    Text(user.username)
                        .font(.system(size: 14, weight: .semibold))

                    Text(user.fullname)
                        .font(.system(size: 14))
                }
                .foregroundColor(.primary)
                Spacer()
            }
            .padding(.horizontal)
            
        }
        .padding(.top)
    }
}

//struct UserCell_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCell()
//            .preferredColorScheme(.dark)
//    }
//}
