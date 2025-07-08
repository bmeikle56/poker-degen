//
//  MainView.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/7/25.
//

import SwiftUI

struct MainView: View {
    let navigationController: UINavigationController

    var body: some View {
        VStack {
            
        }
        .navigationBarHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .ignoresSafeArea()
    }
}

#Preview {
    MainView(navigationController: UINavigationController())
}
