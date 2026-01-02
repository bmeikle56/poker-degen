import UIKit

var currentDeviceType: DeviceType {
    switch UIDevice.current.userInterfaceIdiom {
    case .pad:
        return .iPad
    default:
        return .iPhone
    }
}

enum DeviceType {
    case iPhone
    case iPad
}
