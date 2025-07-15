//
//  AppDelegate.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(
        _ application: UIApplication, 
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        let rootSwiftUIView = LoginView(navigationController: navigationController)
        let hostingController = UIHostingController(rootView: rootSwiftUIView)
        navigationController.viewControllers = [hostingController]
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
