//
//  GameScene.swift
//  SpaceGolf
//
//  Created by Øyvind Grimnes on 03/03/15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import SpriteKit
import UIKit

class GameScene: SKScene {
    var startPoint = CGPoint()
    var endPoint = CGPoint()
    let ball = SKSpriteNode(imageNamed:"ball.png")
    var planets : [Planet] = []
    
    var line = SKShapeNode();
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")

        
//        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
//        Add planets
        
        for i in 0...2 {
            let planet = Planet(texture: SKTexture(imageNamed: "RedPlanet"), radius: 50, fieldStrength: 2)
            planet.position = CGPointMake(CGFloat(arc4random_uniform(UInt32(self.size.width))), CGFloat(arc4random_uniform(UInt32(self.size.height))))
            self.planets.append(planet)
            self.addChild(planet)
        }
        
        
//        Add ball
        let location = CGPoint(x: self.frame.height / 2 , y: self.frame.width/2)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.dynamic = true
        ball.position = location
        ball.setScale(0.1)
        
        self.addChild(ball)

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
            CGPathMoveToPoint(pathToDraw, nil, ball.position.x, ball.position.y)
            CGPathAddLineToPoint(pathToDraw, nil, ball.position.x + (startPoint.x-endPoint.x), ball.position.y + (startPoint.y-endPoint.y))
            
            line.path = pathToDraw
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var force = CGFloat(-9.8)
        var shootVector = CGVectorMake(force*(endPoint.x - startPoint.x),force*(endPoint.y - startPoint.y))
        
        ball.physicsBody?.applyImpulse(shootVector)
        line.removeFromParent()
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
