//
//  LeaderboardViewController.swift
//  SpaceGolf
//
//  Created by Jonas André Dalseth on 16.03.15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import Foundation
import UIKit

class LeaderboardViewController: UIViewController {
    let leaderboard: LeaderboardModel! = LeaderboardModel()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test()
        //customizeFont()
        addPlayersToHighScoreView()
        addScoreToScoreView()
        
        let bgnd = UIImage(named: "bgnd")
        self.view.backgroundColor = UIColor(patternImage: bgnd!)
        
        // Do additional setup after loading the view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Funksjonen som legger spillernavnene til viewet
    func addPlayersToHighScoreView(){
        for player in leaderboard.getLeaderList() {
            highscoreView.insertText("\(player.name)\n")
        }
    }
    
    //Legger til spillerscorene til viewet
    func addScoreToScoreView() {
        for player in leaderboard.getLeaderList() {
            scoreView.insertText("\(player.score)\n")
        }
    }
    
    //Her settes alle fontene
//    func customizeFont() {
//        highscoreView.font = UIFont(name: "Space Comics", size: 12)
//        scoreView.font = UIFont(name: "Space Comics", size: 12)
//        //headerLabel.font = UIFont(name: scoreView.font.fontName, size: 40)
//        
//    }
    //Tekstfelt hvor poengsummen vises
    @IBOutlet weak var scoreView: UITextView!
    
    //Tekstfelt hvor navnene vises
    @IBOutlet weak var highscoreView: UITextView!
    
    //Overskriften
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    //testfunksjon. Brukes bare så lenge vi ikke har noe faktisk objekt å bruke.
    func test(){
        let player1 = Player(id: 1, playerName: "Jonas")
        let player2 = Player(id: 2, playerName: "Thor Martin")
        let player3 = Player(id: 3, playerName: "Lars")
        let player4 = Player(id: 4, playerName: "Kristian")
        let player5 = Player(id: 5, playerName: "Øyvind")
        let player6 = Player(id: 6, playerName: "Robin")
        
        player1.changeScore(100000)
        player4.changeScore(50000)
        player3.changeScore(2000)
        player5.changeScore(200)
        player6.changeScore(60000)
    
    
        leaderboard.addPlayerToLeaderboard(player1)
        leaderboard.addPlayerToLeaderboard(player2)
        leaderboard.addPlayerToLeaderboard(player3)
        leaderboard.addPlayerToLeaderboard(player4)
        leaderboard.addPlayerToLeaderboard(player5)
        leaderboard.addPlayerToLeaderboard(player6)
    }
    
    
    
    
}