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
        var existingPlayers = playersTextView.text
        playersTextView.text = playerTextField.text + "\n" + existingPlayers
        playerTextField.text = ""

    }
    
}