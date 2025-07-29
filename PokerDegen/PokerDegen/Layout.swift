//
//  Layout.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/29/25.
//

struct Layout {
    static let helpView: [DeviceType: HelpViewLayout] = [
        .iPhone: HelpViewLayout(
            spacing: 50,
            horizontalPadding: 250,
            fontSize: 30
        ),
        .iPad: HelpViewLayout(
            spacing: 30,
            horizontalPadding: 60,
            fontSize: 18
        )
    ]
    
    static let settingsView: [DeviceType: SettingsViewLayout] = [
        .iPhone: SettingsViewLayout(
            spacing: 50,
            fontSize: 16,
            buttonWidth: 250,
            buttonHeight: 250,
            bottomPadding: 50
        ),
        .iPad: SettingsViewLayout(
            spacing: 50,
            fontSize: 30,
            buttonWidth: 250,
            buttonHeight: 250,
            bottomPadding: 50
        )
    ]
}
