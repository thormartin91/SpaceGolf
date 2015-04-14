//
//  GameFinishedViewController.swift
//  SpaceGolf
//
//  Created by Jonas André Dalseth on 09.04.15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit


class GameFinishedViewController: UIViewController {
    
    var game: Game?
    var winningPlayer: Player!
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var winnerScoreLabel: UILabel!
    @IBOutlet weak var mainMenuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winningPlayer = game!.currentStandings().first
    
        addResultsToHighscore()
        
        //Setter fonten til player won skriften
        winnerLabel.text = "\(winningPlayer.name) WON!"
        winnerLabel.textColor = UIColor.greenColor()
        winnerLabel.font = UIFont(name: "Space Comics", size: 50)
        
        //Setter fonten til player score fonten
        winnerScoreLabel.text = "SHOTS: \(winningPlayer.score)"
        winnerScoreLabel.textColor = UIColor.greenColor()
        winnerScoreLabel.font = UIFont(name: "Space Comics", size: 30)
    }
    
    func addResultsToHighscore() {
        
        var newScoreDict = [String: Int]()
        if let currentScoreDict = LocalDataHandler.getObjectFromFile(LocalDataFile.PlayerData, key: LocalDataKey.HighScore) as? [String: Int] {
            newScoreDict = currentScoreDict
        }
        
        for player in self.game!.players {
            if let oldScore = newScoreDict[player.name] {
                if oldScore < player.score {
                    continue
                }
            }
            newScoreDict[player.name] = player.score
        }
        
        LocalDataHandler.setObjectForFile(LocalDataFile.PlayerData, object: newScoreDict, key: LocalDataKey.HighScore)
    }
   
    @IBAction func goToMainMenu(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
}

