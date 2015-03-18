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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgnd = UIImage(named: "bgnd.png")
        self.view.backgroundColor = UIColor(patternImage: bgnd!)
        // Do additional setup after loading the view
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resume(sender: AnyObject) {
        // TODO: add functionality that pauses the game
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}