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
    case foam
    case bowling
}

class Ball : SKSpriteNode {
    
    var ballType = BallType.normal {
        didSet {
            self.setTypePhysicsBody()
        }
    }
    
    var originalMass : CGFloat = 10

    
    convenience init(mass: CGFloat, ballType: BallType, size: CGSize) {
        
        self.init();
        
        self.ballType = ballType
        self.size = size
        self.originalMass = mass
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        physicsBody?.categoryBitMask = PhysicsCategory.Ball
        physicsBody?.contactTestBitMask = PhysicsCategory.Planet
        physicsBody?.dynamic = true
        
        self.setTypePhysicsBody()
    }
    
    func setTypePhysicsBody() {
        switch(self.ballType){
        case .normal:
            texture = SKTexture(imageNamed: "ball")
            physicsBody?.angularDamping = 10
            physicsBody?.mass = self.originalMass
            physicsBody?.restitution = 0.3
            break
        case .foam:
            texture = SKTexture(imageNamed: "spaceGolf")
            physicsBody?.angularDamping = 100
            physicsBody?.mass = self.originalMass * 0.5
            physicsBody?.restitution = 0.1
            break
        case .bowling:
            texture = SKTexture(imageNamed: "redPlanet")
            physicsBody?.angularDamping = 20
            physicsBody?.mass = self.originalMass * 2
            physicsBody?.restitution = 0
            break
        }
    }
}