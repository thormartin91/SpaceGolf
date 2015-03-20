//
//  Sound.swift
//  SpaceGolf
//
//  Created by Øyvind Grimnes on 20/03/15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import Foundation
import AudioToolbox

class Sound {
    class func playSoundWithName(name: String, ofType type: String) {
        let path = NSBundle.mainBundle().pathForResource(name, ofType: type)
        
        if path == nil {
            return
        }
        
        
        let pathURL = NSURL(fileURLWithPath: path!)
        
        var audioEffect : SystemSoundID = SystemSoundID()
        
        AudioServicesCreateSystemSoundID(pathURL!, &audioEffect)
        AudioServicesPlaySystemSound(audioEffect)

//        TODO: Should dispose of sound, but not wure if this solution is possible in Swift
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (30 * NSEC_PER_SEC) as Int64), dispatch_get_main_queue()) { () -> Void in
//            AudioServicesDisposeSystemSoundID(audioEffect)
//        }
    }
}