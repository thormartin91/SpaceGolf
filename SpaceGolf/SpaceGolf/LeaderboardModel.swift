//
//  Leaderboard.swift
//  SpaceGolf
//
//  Created by Jonas André Dalseth on 04.03.15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardModel {
    private var leaderList: [Player]
    private var length: Int
    
    init (length: Int) {
        leaderList = [Player]()
        self.length = length
    }
    
    init() {
        leaderList = [Player]()
        self.length = 5
    }
    
    //Antar at listen er sortert
    func addPlayerToLeaderboard(player: Player) {
        if (playerOnHighScoreList(player)) {
            if (leaderList.count >= length){
                removePlayerFromList(lastPlayerOnLeaderboard())
                leaderList.append(player)
            }
            else {
                leaderList.append(player)
            }
            
        }
        leaderList.sort({$0.score > $1.score})
    }
    
    //Sjekker om brukeren har høy nok score til å komme på highscoreListen
    func playerOnHighScoreList(player: Player) -> Bool {
        if (leaderList.count <= length) {
            return true;
        }
        else {
            if (player.score > lastPlayerOnLeaderboard().score) {
                return true
            }
            
        }
        return  false
    }
    
    /*Finds the last player on the leaderboard.
     *May be optimized if leaderboard are sorted.
     */
    
    func lastPlayerOnLeaderboard() -> Player {
        var lowestScore: Player = leaderList[0]
        for player in leaderList {
            if (player.score < lowestScore.score) {
                lowestScore = player
            }
        }
        return lowestScore;
    }
    
    func removePlayerFromList(player: Player) {
        for var i = 0; i < leaderList.count; i++ {
            if (leaderList[i] == player) {
                leaderList.removeAtIndex(i)
                return
            }
        }
    }
    
    func getLeaderList() -> [Player] {
        return leaderList
    }
}
