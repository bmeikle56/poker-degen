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
    
    static let loginView: [DeviceType: LoginViewLayout] = [
        .iPhone: LoginViewLayout(
            titleScale: 26,
            spacing: 20,
            fontSize: 16,
            buttonWidth: 200,
            buttonHeight: 50,
        ),
        .iPad: LoginViewLayout(
            titleScale: 50,
            spacing: 50,
            fontSize: 28,
            buttonWidth: 350,
            buttonHeight: 100,
        )
    ]
    
    static let signupView: [DeviceType: SignupViewLayout] = [
        .iPhone: SignupViewLayout(
            titleScale: 16,
            spacing: 30,
            fontSize: 16,
            buttonWidth: 150,
            buttonHeight: 60,
        ),
        .iPad: SignupViewLayout(
            titleScale: 30,
            spacing: 30,
            fontSize: 16,
            buttonWidth: 150,
            buttonHeight: 60,
        )
    ]
}
