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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do additional setup after loading the view
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "bgnd")?.drawInRect(self.view.bounds)
        var image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        if(GameSounds.sharedInstance.isBackgroundMusicOn == false){
            backgroundMusicSwitch.on = false
        }
        
        if(GameSounds.sharedInstance.isMusicEffectsOn == false){
            soundEffectsSwitch.on = false
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

        
        var toggleSwitch = sender as! UISwitch
    
        if(toggleSwitch.on){
            GameSounds.sharedInstance.unMuteSoundEffects()
        }else{
            GameSounds.sharedInstance.muteSoundEffects()
        }


    }

    @IBAction func musicToggleSwitched(sender: AnyObject) {
        
        var musicSwitch = sender as! UISwitch
        
        if(musicSwitch.on){
            GameSounds.sharedInstance.resumeBackgroundMusic()
        }else{
            GameSounds.sharedInstance.pauseBackgroundMusic()
        }
        
    }



}