
//TODO: Generate a profile picture
//TODO:

import SwiftUI

struct ConversationCell: View {
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
            Divider()
        }
        .padding(.top)
    }
}

struct ConversationCell_Previews: PreviewProvider {
    static var previews: some View {
        ConversationCell()
            .preferredColorScheme(.dark)
    }
}
