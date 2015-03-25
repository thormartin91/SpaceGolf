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
    var currentBackroundMusicTime : NSTimeInterval = 0.0

    
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
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    
    }
    
    
    func playBackgroundMusic(){
        playSoundWithName("music", ofType: "mp3")
    }
    
    func stopBackgroundMusic(){
        audioPlayer.stop()
    }
    
    func pauseBackgroundMusic(){
        
        
        currentBackroundMusicTime = audioPlayer.currentTime

        audioPlayer.pause()
    }
    
    func resumeBackgroundMusic(){
        println(currentBackroundMusicTime)
        audioPlayer.prepareToPlay()
        audioPlayer.playAtTime(currentBackroundMusicTime)
    }
   
    
    
    
}