//
//  Planet.swift
//  SpaceGolf
//
//  Created by Øyvind Grimnes on 03/03/15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import SpriteKit

struct PhysicsFieldCategory {
    static let PlanetGravitation : UInt32    = 0x1 << 1
}

enum PlanetState {
    case Hole
    case Normal
}

class Planet: SKSpriteNode {

    var state : PlanetState = .Normal
    
    var radius : Float {
        return Float(self.size.height) / 2.0
    }
    
    var holeRadius : Float = 10.0
    var holeAngle : Float = 0
    
    let gravityField : SKFieldNode = SKFieldNode.radialGravityField()
    
    init(texture: SKTexture, radius: CGFloat, fieldStrength: Float) {

        super.init(texture: texture, color: UIColor.redColor(), size: CGSizeMake(radius*2, radius*2))
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.dynamic = false
        
        self.configureGravityFieldWitStrength(fieldStrength)
        self.addChild(self.gravityField)
    }
    
    func configureGravityFieldWitStrength(strength: Float) {
        self.gravityField.strength = strength
//        self.gravityField.falloff = 2
        self.gravityField.categoryBitMask = PhysicsFieldCategory.PlanetGravitation
    }
 
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func isInTheHole(ball: Ball) -> Bool {
        if self.state != .Hole {
            return false
        }
        
//        The aproximate angle from center of the hole to the edge
        let radiusAngle : Float = asin(self.holeRadius / self.radius)
        
//        The angles corresponting to the left and right edge of the hole
        let minAngle : Float = self.holeAngle - radiusAngle
        let maxAngle : Float = self.holeAngle + radiusAngle

//        Angle between the planet center and the ball
        let ballAngle : Float = Float(atan2(self.position.y - ball.position.y, self.position.x - ball.position.x))

        return (ballAngle < maxAngle) && (ballAngle > minAngle)
    }
}
