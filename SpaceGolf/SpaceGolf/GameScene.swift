//
//  GameScene.swift
//  SpaceGolf
//
//  Created by Øyvind Grimnes on 03/03/15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import SpriteKit
import UIKit

struct PhysicsCategory {
    static let None         : UInt32 = 0
    static let All          : UInt32 = UInt32.max
    static let Ball         : UInt32 = 0x1 << 1
    static let Planet      : UInt32 = 0x1 << 2
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var startPoint = CGPoint()
    var endPoint = CGPoint()
    var ball : Ball?
    var planets : [Planet] = []
    
    var line = SKShapeNode();
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")

        
//        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
//        Add planets
        
        let positions : [(CGFloat, CGFloat)] = [(100,200), (400,100), (500,300)]
        for pos in positions {
            let planet = Planet(texture: SKTexture(imageNamed: "RedPlanet"), radius: 50, fieldStrength: 2)
            planet.position = CGPointMake(pos.0, pos.1)
            self.planets.append(planet)
            self.addChild(planet)
        }
        
//        Add ball
        ball = Ball(mass: 2, ballType: normal, size: CGSizeMake(200, 200))
        
        println(ball)
        
        self.addChild(ball!)

    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        self.addChild(line)
        for touch: AnyObject in touches {
            startPoint = touch.locationInNode(self)
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            endPoint = touch.locationInNode(self)
            
            let pathToDraw = CGPathCreateMutable()
            CGPathMoveToPoint(pathToDraw, nil, ball!.position.x, ball!.position.y)
            
            CGPathAddLineToPoint(pathToDraw, nil, ball!.position.x + (startPoint.x-endPoint.x), ball!.position.y + (startPoint.y-endPoint.y))
            
            line.path = pathToDraw
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var force = CGFloat(-9.8)
        var shootVector = CGVectorMake(force*(endPoint.x - startPoint.x),force*(endPoint.y - startPoint.y))
        
        ball?.physicsBody?.applyImpulse(shootVector)
        line.removeFromParent()
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var ball : Ball? = ballDidHitPlanet(contact).0
        var planet : Planet? = ballDidHitPlanet(contact).1

       
        if (ball != nil ||
            planet != nil){
                
            planet!.isInTheHole(ball!)
       
        }
        
        
        
    }
    
    
    func ballDidHitPlanet(contact: SKPhysicsContact) -> (Ball?, Planet?){
    
        if (contact.bodyA.categoryBitMask == PhysicsCategory.Ball &&
            contact.bodyB.categoryBitMask == PhysicsCategory.Planet){
        
                return (contact.bodyA.node as? Ball, contact.bodyB.node as? Planet)
    
        } else if (contact.bodyB.categoryBitMask == PhysicsCategory.Ball &&
                   contact.bodyA.categoryBitMask == PhysicsCategory.Planet){
        
                    return (contact.bodyB.node as? Ball, contact.bodyA.node as? Planet)

        } else {
                return (nil,nil)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
