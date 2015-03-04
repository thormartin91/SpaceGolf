//
//  GameScene.swift
//  SpaceGolf
//
//  Created by Øyvind Grimnes on 03/03/15.
//  Copyright (c) 2015 Progark. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    
    let planet = Planet(radius: 50, density: 0.3)
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        planet.position = CGPointMake(self.size.width/2, self.size.height/2)
        planet.state = PlanetState.Hole
        self.addChild(planet)
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        
        let planet2 : Planet = Planet(radius: 50, density: 0.3)
        planet2.position = CGPointMake(self.size.width/2+150, self.size.height/2-150)
        self.addChild(planet2)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
//        for touch: AnyObject in touches {
//            let location = touch.locationInNode(self)
//            
//            let sprite = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(30, 30))
//            sprite.physicsBody = SKPhysicsBody(circleOfRadius: 15)
//            sprite.physicsBody?.fieldBitMask = PhysicsFieldCategory.PlanetGravitation
//            sprite.position = location
//            sprite.physicsBody?.angularDamping = 5
//            
//            self.addChild(sprite)
//            
//            sprite.physicsBody?.applyImpulse(CGVectorMake(4, 0))
//        }
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)

            let ball = Ball(color: UIColor.grayColor(), size: CGSizeMake(20, 20))
            ball.position = location
//            self.addChild(ball)
            println(self.planet.isInTheHole(ball))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
