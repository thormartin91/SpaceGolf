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
    var score: Double
    private var hits: Int
    var ball: Ball
    
    init(id: Int){
        score = 0
        hits = 0
        ball = Ball()
        self.id = id;
    }
    
    func changeScore(deltaScore: Double){
        score += deltaScore;
    }
    
    func addHit(){
        hits++
    }
    
    func getHits() -> Int {
        return self.hits
    }
    
    
}