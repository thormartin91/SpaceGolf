//
//  GameSettingsViewController.swift
//  SpaceGolf
//
//  Created by Thor Martin Abrahamsen on 06.03.15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import UIKit

class GameSettingsViewController: UIViewController {
    
    @IBOutlet weak var backgroundMusicSwitch: UISwitch!
    @IBOutlet weak var soundEffectsSwitch: UISwitch!
    
    var gameSounds : GameSounds? {
        didSet {
//            println("Yay")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do additional setup after loading the view
        let bgnd = UIImage(named: "bgnd")
        self.view.backgroundColor = UIColor(patternImage: bgnd!)
        
        
        if(gameSounds?.isBackgroundMusicOn == false){
            backgroundMusicSwitch.on = false
        }
        
        if(gameSounds?.isMusicEffectsOn == false){
            backgroundMusicSwitch.on = false
        }

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

    @IBAction func soundEffectsToggleSwitched(sender: AnyObject) {

        var toggleSwitch = sender as UISwitch
        
        if(toggleSwitch.on){
            gameSounds!.resumeBackgroundMusic()
        }else{
            gameSounds!.pauseBackgroundMusic()
        }


    }

    @IBAction func musicToggleSwitched(sender: AnyObject) {
        
        var musicSwitch = sender as UISwitch
        
        if(musicSwitch.on){
            gameSounds!.muteSoundEffects()
        }else{
            gameSounds!.unMuteSoundEffects()
        }
        
    }



}