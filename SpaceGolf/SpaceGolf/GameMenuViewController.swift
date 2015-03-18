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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do additional setup after loading the view
        let spaceGolf = UIImage(named: "SpaceGolf.png")
        self.view.backgroundColor = UIColor(patternImage: spaceGolf!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}