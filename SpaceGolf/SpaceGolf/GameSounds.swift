//
//  GameSounds.swift
//  SpaceGolf
//
//  Created by Kristian Bjørn Thoresen on 25.03.15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import Foundation
import AVFoundation

class GameSounds {
    
    var audioPlayer = AVAudioPlayer()
    var isBackgroundMusicOn : Bool
    var isMusicEffectsOn : Bool

    init(){
        isMusicEffectsOn = true
        isBackgroundMusicOn = true
        
    }
    
    
    func playSoundWithName(name: String, ofType type: String) {
        let soundURL = NSURL(fileURLWithPath:(NSBundle.mainBundle().pathForResource(name, ofType: type))!)
        
        if soundURL == nil {
            return
        }
        
        //        var alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("button-09", ofType: "wav"))
        //        println(alertSound)
        
        // Removed deprecated use of AVAudioSessionDelegate protocol
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, error: nil)
        AVAudioSession.sharedInstance().setActive(true, error: nil)
        
        
        audioPlayer = AVAudioPlayer(contentsOfURL: soundURL, error: nil)
        audioPlayer.play()
        audioPlayer.numberOfLoops = -1

    }
    
    
    func playBackgroundMusic(){
        playSoundWithName("music", ofType: "mp3")
        isBackgroundMusicOn = true

    }
    
    func stopBackgroundMusic(){
        audioPlayer.stop()
        isBackgroundMusicOn = false

    }
    
    func pauseBackgroundMusic(){
        audioPlayer.pause()
        isBackgroundMusicOn = false

    }
    
    func resumeBackgroundMusic(){
        audioPlayer.play()
        isBackgroundMusicOn = true

    }
    
    func unMuteSoundEffects(){
        isMusicEffectsOn = true

    }
    
    func muteSoundEffects(){
        isMusicEffectsOn = false

    }
   
    func playEffectSoundWithName(name: String, ofType type: String) {
        
        
        if(isMusicEffectsOn == true){
            let path = NSBundle.mainBundle().pathForResource(name, ofType: type)
            
            if path == nil {
                return
            }
            
            
            let pathURL = NSURL(fileURLWithPath: path!)
            
            var audioEffect : SystemSoundID = SystemSoundID()
            
            AudioServicesCreateSystemSoundID(pathURL!, &audioEffect)
            AudioServicesPlaySystemSound(audioEffect)
        }

        

//        TODO: Should dispose of sound, but not sure if this solution is possible in Swift
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (30 * NSEC_PER_SEC) as Int64), dispatch_get_main_queue()) { () -> Void in
//        AudioServicesDisposeSystemSoundID(audioEffect)
//        }
    }
    
    
}