//
//  GameSettingsViewController.swift
//  SpaceGolf
//
//  Created by Thor Martin Abrahamsen on 06.03.15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import UIKit

class GameSettingsViewController: UIViewController {
    
    var gameSounds : GameSounds? {
        didSet {
            println("Yay")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do additional setup after loading the view
        let bgnd = UIImage(named: "bgnd")
        self.view.backgroundColor = UIColor(patternImage: bgnd!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func musicToggleSwitched(sender: AnyObject) {
        
        var musicSwitch = sender as UISwitch
        
        if(musicSwitch.on){
            gameSounds!.resumeBackgroundMusic()

        }else{
            gameSounds!.pauseBackgroundMusic()
        }
        

    }
}