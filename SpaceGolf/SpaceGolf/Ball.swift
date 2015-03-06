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

    
    convenience init(mass: Int, ballType: Int, size: CGSize) {
        
        self.init();

        self.ballType = ballType
        self.size = size
        texture = SKTexture(imageNamed: "ball.png")
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        physicsBody?.dynamic = true
        physicsBody?.mass = CGFloat(mass)
        physicsBody?.categoryBitMask = PhysicsCategory.Ball
        physicsBody?.contactTestBitMask = PhysicsCategory.Planet
    }
    
//    override init() {
//        super.init(texture: SKTexture(imageNamed: "ball"), color: UIColor.redColor(), size: CGSizeMake(20, 20));
//        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
//        self.physicsBody?.angularDamping = 10
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
//    func applyImpulse(vector: CGVector){
//        
//    }

    
}