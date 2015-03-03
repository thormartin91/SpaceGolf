//
//  GameScene.swift
//  SpaceGolf
//
//  Created by Øyvind Grimnes on 03/03/15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var startPoint = CGPoint()
    var endPoint = CGPoint()
    let ball = SKSpriteNode(imageNamed:"ball.png")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")

        
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: view.frame)
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        
        let ball = SKSpriteNode(imageNamed:"ball.png")
        let location = CGPoint(x: self.frame.height / 2 , y: self.frame.width/2)
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.dynamic = true
        ball.physicsBody?.velocity = CGVectorMake(0, 0)
        ball.physicsBody?.applyForce(CGVectorMake(0, 280))
        
        ball.position = location
        ball.setScale(0.1)
        
        self.addChild(ball)
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
            startPoint = touch.locationInNode(self)
            println("Start: \(startPoint)")
            
        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
                endPoint = touch.locationInNode(self)
                println("End: \(endPoint)")
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var shootVector = CGVectorMake(endPoint.x - startPoint.x, endPoint.y - startPoint.y)
        
        println("Vector: \(shootVector.dx),\(shootVector.dy)")
        
        ball.physicsBody?.applyImpulse(shootVector)
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
