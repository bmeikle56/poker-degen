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
    
    static let pokerTableView: [DeviceType: PokerTableViewLayout] = [
        .iPhone: PokerTableViewLayout(
            spacing: 20,
            fontSize: 20,
            iconSize: 20,
            communityCardSize: 80,
            playerCardSize: 80,
            buttonWidth: 80,
            buttonHeight: 80,
            bottomPadding: 20
        ),
        .iPad: PokerTableViewLayout(
            spacing: 20,
            fontSize: 20,
            iconSize: 20,
            communityCardSize: 80,
            playerCardSize: 80,
            buttonWidth: 80,
            buttonHeight: 80,
            bottomPadding: 20
        )
    ]
}
