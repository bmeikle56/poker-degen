//
//  WebView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/25/25.
//

import SwiftUI
import SafariServices

extension UIApplication {
    static func topViewController(controller: UIViewController? = UIApplication.shared.connectedScenes
        .compactMap { ($0 as? UIWindowScene)?.keyWindow }
        .first?.rootViewController) -> UIViewController? {
        if let nav = controller as? UINavigationController {
            return topViewController(controller: nav.visibleViewController)
        }
        if let tab = controller as? UITabBarController {
            return topViewController(controller: tab.selectedViewController)
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

struct WebLinkText: View {
    let text: String
    let url: String
    let navigationController: UINavigationController

    @State private var showWebView = false

    var body: some View {
        Text(text)
            .foregroundColor(.gray)
            .underline()
            .onTapGesture {
                if let topVC = UIApplication.topViewController() {
                    let safariVC = SFSafariViewController(url: URL(string: url)!)
                    safariVC.modalPresentationStyle = .overFullScreen
                    navigationController.modalPresentationStyle = .overFullScreen
                    topVC.present(safariVC, animated: true, completion: nil)
                }
            }
    }
}
