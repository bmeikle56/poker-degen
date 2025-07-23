//
//  HandViewModel.swift
//  PokerDegen
//
//  Created by Braeden Meikle on 7/21/25.
//

import SwiftUI

struct BoardData: Codable {
    let board: CardData
}

struct CardData: Codable {
    let cc1, cc2, cc3, cc4, cc5: String
    let hc1, hc2: String
    let v1c1, v1c2: String
    let pot: String
    let vpt, vp, hp: String
}

class HandViewModel: ObservableObject {
    /// cc4 = Community Card 4 (the turn)
    @Published var cc1: String = "card"
    @Published var cc2: String = "card"
    @Published var cc3: String = "card"
    @Published var cc4: String = "card"
    @Published var cc5: String = "card"
    
    /// hc1 = Hero Card 1
    @Published var hc1: String = "card"
    @Published var hc2: String = "card"
    
    /// v1c2 = Villian 1 Card 2
    @Published var v1c1: String = "card"
    @Published var v1c2: String = "card"
    
    /// vfb = Villain Flop Bet
    @Published var vfb: Int = 0
    
    /// hfb = Hero Flop Bet
    @Published var hfb: Int = 0
    
    /// vpt = Villain Player Type
    @Published var vpt: String = "Player Type"
    
    /// vp = Villain Position
    @Published var vp: String = "Position"
    
    /// hp = Hero Position
    @Published var hp: String = "Position"
    
    var boardData: BoardData {
        BoardData(board: CardData(cc1: cc1, cc2: cc2, cc3: cc3, cc4: cc4, cc5: cc5, hc1: hc1, hc2: hc2, v1c1: v1c1, v1c2: v1c2, pot: String(Int(vfb+hfb)), vpt: vpt, vp: vp, hp: hp))
    }
}
