//
//  MenuViewController.swift
//  SpaceGolf
//
//  Created by Thor Martin Abrahamsen on 04.03.15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import UIKit
import SpriteKit

class GameMenuViewController: UIViewController {
    
    @IBOutlet weak var btn_play: UIButton!
    @IBOutlet weak var highScoreButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    var buttons : [UIButton] {
        return [self.btn_play, self.highScoreButton, self.settingsButton]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do additional setup after loading the view
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "SpaceGolf.png")?.drawInRect(self.view.bounds)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)

        
        
//        let spaceGolf = UIImage(named: "SpaceGolf.png")
        GameSounds.sharedInstance.playBackgroundMusic()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSettings" {
            let settingsVC = segue.destinationViewController as! GameSettingsViewController
//            settingsVC.navigationController?.navigationBarHidden = true
        }else if segue.identifier == "ShowAddPlayers" {
            let addPlayersVC = segue.destinationViewController as! AddPlayersViewController
        }
    }
    
    
    
}