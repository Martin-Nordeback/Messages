import SwiftUI

/*
 Model for connection future function with ui, having multiple options inside of the settings
 */
enum SettingsCellViewModel: Int, CaseIterable {
    case account
    case notifications
    case starredMessages

    var title: String {
        switch self {
        case .account: return "Account"
        case .notifications: return "Notifications"
        case .starredMessages: return "StarredMessages"
        }
    }

    var imageName: String {
        switch self {
        case .account: return "key.fill"
        case .notifications: return "bell.badge.fill"
        case .starredMessages: return "star.fill"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .account: return .orange
        case .notifications: return .red
        case .starredMessages: return .yellow
        }
    }
}
