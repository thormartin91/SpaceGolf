//
//  Player.swift
//  SpaceGolf
//
//  Created by Jonas André Dalseth on 04.03.15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import Foundation
import GameKit
import SpriteKit

class Player: GKLocalPlayer {
    let id: Int
    var score: Int
    private var hits: Int
    var ball: Ball
    var name: String
    
    init(id: Int, playerName: String){
        score = 0
        hits = 0
        name = playerName.uppercaseString
        ball = Ball(mass: 1, ballType: BallType.normal, size: CGSize(width: 20, height: 20))
        self.id = id;
    }
    
    func changeScore(deltaScore: Int){
        score += deltaScore;
    }
    
    func addHit(){
        hits++
    }
    
    func getHits() -> Int {
        return self.hits
    }
    
    
}