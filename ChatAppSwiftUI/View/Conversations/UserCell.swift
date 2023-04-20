
//TODO: Generate a profile picture
//TODO:

import SwiftUI

struct UserCell: View {
    var body: some View {
        VStack {
            HStack {
                // change default picutre
                Image(systemName: "sun.min")

                // Message info

                VStack(alignment: .leading, spacing: 4) {
                    Text("Martin Nordeback")
                        .font(.system(size: 14, weight: .semibold))

                    Text("@something?!")
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

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell()
            .preferredColorScheme(.dark)
    }
}
