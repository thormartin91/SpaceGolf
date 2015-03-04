//
//  Planet.swift
//  SpaceGolf
//
//  Created by Øyvind Grimnes on 03/03/15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import SpriteKit

class Ball : SKSpriteNode {}

struct PhysicsFieldCategory {
    static let PlanetGravitation : UInt32    = 0x1 << 1
}


enum PlanetState {
    case Hole
    case Normal
}

protocol GoalPlanetDelegate {
    func ballDidHitGoal(ball: Ball, onPlanet planet:Planet)
}

class Planet: SKSpriteNode {

    var state : PlanetState = .Normal {
        didSet {
//            Noe
        }
    }
    
    var radius : Float {
        return Float(self.size.height) / 2.0
    }
    
    var holeRadius : Float = 10.0
    var holeAngle : Float = 0
    
    let gravityField : SKFieldNode = SKFieldNode.radialGravityField()
    
    init(radius: Float, density: Float) {
        
//        TODO: Randomize planet texture?
        super.init(texture: SKTexture(imageNamed: "RedPlanet"), color: UIColor.redColor(), size: CGSizeMake(CGFloat(radius*2), CGFloat(radius*2)))
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(radius))
        self.physicsBody?.dynamic = false
        
//        Add gravitational pull
//        Field strength = volume * density
        self.gravityField.strength = powf(radius, 2) * Float(M_1_PI) * density * 0.01
        self.gravityField.categoryBitMask = PhysicsFieldCategory.PlanetGravitation

        self.addChild(self.gravityField)
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
