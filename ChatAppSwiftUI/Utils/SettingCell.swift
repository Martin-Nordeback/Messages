import SwiftUI

// represent the apps setting rows with different settings
struct SettingsCell: View {
    //ref to the enum where we have multiple computed properties to bee able to reuse view and functionality
    let viewModel: SettingsCellViewModel

    var body: some View {
        VStack {
            HStack {
                Image(systemName: viewModel.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .padding(6)
                    .background(viewModel.backgroundColor)
                    .foregroundColor(
                        .white)
                    .cornerRadius(6)
                Text(viewModel.title)
                    .font(.system(size: 15))

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
            .padding([.top, .horizontal])
            

            Divider()
                .padding(.leading)
        }
        .background(Color(.systemGray6))
        .cornerRadius(12)

    }
}
