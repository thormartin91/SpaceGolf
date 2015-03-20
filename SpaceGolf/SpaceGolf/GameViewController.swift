//
//  GameViewController.swift
//  SpaceGolf
//
//  Created by Øyvind Grimnes on 03/03/15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

    var game : Game?
    
    @IBOutlet weak var currentPlayerLabel: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let scene = GameScene(size: self.view.bounds.size)
        scene.game = self.game
        
        let skView = view as SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .ResizeFill
        skView.presentScene(scene)
        setPlayerLabel()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.LandscapeLeft.rawValue)
    }
    
    
//    MARK: - This should probably be located in the game scene.
    func setPlayerLabel() { // TODO: Does not update roundbased
        if let player = game?.getCurrentPlayer() {
            currentPlayerLabel.text = player.name
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowPauseScene" {
            let pauseVC = segue.destinationViewController as PauseMenuViewController
            pauseVC.game = self.game
            pauseVC.navigationController?.navigationBarHidden = true
        }
    }
    
}
