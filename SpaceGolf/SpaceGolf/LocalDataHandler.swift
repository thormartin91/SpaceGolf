//
//  LocalDataHandler.swift
//  SpaceGolf
//
//  Created by Øyvind Grimnes on 03/03/15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import Foundation


class LocalDataHandler {
    
    class func getObjectFromFile(file : String, key : String) -> AnyObject? {
        return LocalDataHandler.getDataFromFile(file)[key]
    }
    
//    Add object to dict in file
    class func setObjectForFile(file : String, object : AnyObject, key : String) {
        
//        Get data currently on the device
        var dict = NSMutableDictionary(dictionary: LocalDataHandler.getDataFromFile(file))
        dict[key] = object
        
//        Construct path to the file in documents directory
        let documentsDir : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        var plistPath : String = documentsDir + "/" + file + ".plist"
        
//        Write to file
        dict.writeToFile(plistPath, atomically: true)
    }
    
//    Get the dict from file
    class func getDataFromFile(file: String) -> [NSObject: AnyObject]{
//        Construct path to the file in documents directory
        let documentsDir : String = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as String
        var plistPath : String = documentsDir + "/" + file + ".plist"
        
//        If there is a file at the path, return the data
        if NSFileManager.defaultManager().fileExistsAtPath(plistPath) {
            return NSMutableDictionary(contentsOfFile: plistPath)! as [NSObject: AnyObject]
        }
        
//        Else, return an empty dictionary
        return [NSString: AnyObject]()
    }
    
}