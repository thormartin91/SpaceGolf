//
//  Leaderboard.swift
//  SpaceGolf
//
//  Created by Jonas André Dalseth on 04.03.15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import Foundation

class Leaderboard {
    private var leaderList = [Player]()
    
    
    
    func addPlayerToLeaderboard(player: Player) {
        
    }
    
    func playerOnHighScoreList(player: Player) -> Bool {
        if (leaderList.count <= 5) {
            leaderList.append(player)
        }
        else {
            if (player.score > lowestScoreOnLeaderboard().score) {
                
            }
            
        }
    }
    
    func lastPlayerOnLeaderboard() -> Player {
        var lowestScore: Player = leaderList[0]
        for player in leaderList {
            if (player.score < lowestScore.score) {
                lowestScore = player
            }
        }
        return lowestScore;
    }
    
}
