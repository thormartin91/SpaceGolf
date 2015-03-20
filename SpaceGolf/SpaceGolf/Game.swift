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
    private var idCounter : Int = 0
    private var playersDone : [Player] = []
    
    private var currentPlayer : Int = 0 {
        didSet {
            self.currentPlayer = currentPlayer % self.players.count
        }
    }
    private var firstPlayer : Int = 0 {
        didSet {
            self.firstPlayer = firstPlayer % self.players.count
        }
    }
    
    
    func addPlayer(name: String) {
        var player = Player(id: idCounter, playerName: name)
        idCounter += 1
        self.players.append(player)
    }
    
    func removePlayer(player: Player) {
        self.players.filter() {$0.id != player.id}
    }
    
    func newRound() {
        self.currentPlayer = firstPlayer++
        self.playersDone = []
    }
    
    func nextPlayer() -> Player? {
        self.getCurrentPlayer()?.score++
        
        if self.players.count == 0 || self.players.count == self.playersDone.count {
            return nil
        }
        
        var nextPlayer = self.players[self.currentPlayer++]
        while contains(self.playersDone, nextPlayer) {
            nextPlayer = self.players[self.currentPlayer++]
        }
        
        return nextPlayer
    }
    
    func currentStandings() -> [Player] {
        return sorted(self.players) {$0.score > $1.score}
    }
    
    func roundIsDone() -> Bool {
        return self.players.count == self.playersDone.count
    }
    
    func playerIsDone(player: Player) {
        if !contains(self.playersDone, player) {
            self.removePlayer(player)
            self.playersDone.append(player)
        }
    }
    
    func playerForBall(ball: Ball)-> Player? {
        for player in self.players {
            if player.ball == ball {
                return player
            }
        }
        
        return nil
    }
    
    func getCurrentPlayer() -> Player? {
        for player in players {
            if player.id == currentPlayer {
                return player
            }
        }
        return nil
    }
    
}