//
//  Ball.swift
//  SpaceGolf
//
//  Created by Kristian Bjørn Thoresen on 03.03.15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import Foundation
import SpriteKit

enum BallType : Int{
    case normal
}

class Ball : SKSpriteNode {
    
    var ballType = normal
    
    convenience init(mass: Int, ballType: Int) {
        
        self.init();
        self.physicsBody?.mass = CGFloat(mass);
        self.ballType = ballType;
        
    }
    
    func applyImpulse(vector: CGVector){
        
    }
    
}