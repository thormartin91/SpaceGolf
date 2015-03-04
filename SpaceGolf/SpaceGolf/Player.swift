//
//  Player.swift
//  SpaceGolf
//
//  Created by Jonas André Dalseth on 04.03.15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import Foundation
import GameKit

class Player: GKLocalPlayer {
    private var score: Double
    private var hits: Int
    private var ball: Ball
    
    override init(){
        score = 0
        hits = 0
        ball = Ball()
    }
    
    func changeScore(deltaScore: Double){
        score += deltaScore;
    }
    
    func addHit(){
        hits++
    }
    
    func getScore() -> Double {
        return self.score
    }
    
    func getHits() -> Int {
        return self.hits
    }
    
    
}