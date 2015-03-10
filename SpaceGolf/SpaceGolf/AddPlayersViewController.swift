//
//  AddPlayersViewController.swift
//  SpaceGolf
//
//  Created by Thor Martin Abrahamsen on 06.03.15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import UIKit
import SpriteKit

class AddPlayersViewController: UIViewController {
    
    @IBOutlet weak var playerTextField: UITextField!
    @IBOutlet weak var playersTextView: UITextView!
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do additional setup after loading the view
        playerTextField.placeholder = "Enter name..."
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPlayerButton(sender: AnyObject) {
        // update view with playername
        playersTextView.text = playerTextField.text + "\n" + playersTextView.text
        // add player to game
        game.addPlayer(playerTextField.text)
        // clear textfield
        playerTextField.text = ""
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowGameScene" {
            let gameVC = segue.destinationViewController as GameViewController
            gameVC.game = self.game
            gameVC.navigationController?.navigationBarHidden = true
        }
    }
}