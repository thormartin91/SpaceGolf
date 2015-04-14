//
//  PauseMenuViewController.swift
//  SpaceGolf
//
//  Created by Thor Martin Abrahamsen on 12.03.15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import UIKit
import SpriteKit

class PauseMenuViewController: UIViewController {
    
    var game : Game?
    
    /** Reference to the TextView with player names **/
    @IBOutlet weak var currentScoreNames: UITextView!
    /** Reference to the TextView with splayer scores **/
   // @IBOutlet weak var currentScoreScores: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "bgnd")?.drawInRect(self.view.bounds)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)

        // Do additional setup after loading the view
        currentScoreList()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resume(sender: AnyObject) {
        // TODO: add functionality that pauses the game
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func mainMenu(sender: AnyObject) {
        (self.presentingViewController as! UINavigationController?)?.popToRootViewControllerAnimated(false)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /** Fills out the current standings **/
    // TODO: When list ranges out of screen the scrolling of names and scores are not synced
    func currentScoreList() {
        if let players = game?.currentStandings() {
            for player in players {
            currentScoreNames.text = currentScoreNames.text + "\n" + player.name + "\t" + "\(player.score)"
            //currentScoreScores.text = currentScoreScores.text + "\n" + "\(player.score)"
            }
        }
    }
}