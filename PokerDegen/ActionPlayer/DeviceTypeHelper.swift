//
//  DeviceTypeHelper.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/29/25.
//

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
