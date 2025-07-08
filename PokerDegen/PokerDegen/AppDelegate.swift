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

        // Create the root UIKit navigation controller
        let navigationController = UINavigationController()

        // Embed your SwiftUI view inside a UIHostingController
        let rootSwiftUIView = LoginView()
        //let hostingController = UIHostingController(rootView: rootSwiftUIView)
        let hostingController = UIHostingController(rootView: rootSwiftUIView)

        // Push the SwiftUI hosting controller into the nav stack
        navigationController.viewControllers = [hostingController]

        window?.backgroundColor = .white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
