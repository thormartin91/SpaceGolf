//
//  Game.swift
//  SpaceGolf
//
//  Created by Øyvind Grimnes on 05/03/15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import Foundation


class Game {
    var players : [Player] = []
    private var currentPlayer : Int = 0
    
    func addPlayer(player: Player) {
        self.players.append(player)
    }
    
    func removePlayer(player: Player) {
        self.players.filter() {$0.id != player.id}
    }
    
    func newRound() {
        self.currentPlayer = 0
    }
    
    func nextPlayer() -> Player? {
        if self.players.count == 0 {
            return nil
        }
        
        return self.players[self.currentPlayer++]
    }
    
    func currentStandings() -> [Player] {
        return sorted(self.players) {$0.score > $1.score}
    }
}