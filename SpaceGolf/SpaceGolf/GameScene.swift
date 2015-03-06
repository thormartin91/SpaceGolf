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

    var planets : [Planet] = []
    
    var line = SKShapeNode();
    
    var game : Game?
    var currentPlayer : Player?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
//        TODO: Should be a partog AddPlayerVC
        self.game = Game()
        self.game?.players = [Player(id: 0), Player(id: 1)]
        
        self.newRound()
    }

//    TODO: Should update map
    func newRound() {
        
        self.addPlanets()
        
        self.game?.newRound()
        
        for player in self.game!.players {
            player.ball.position = CGPoint(x: 100, y: 100)
            self.addChild(player.ball)
        }
        
        self.nextPlayer()
    }
    
    func nextPlayer() {
        if !self.game!.roundIsDone() {
            self.currentPlayer = self.game?.nextPlayer()
        } else {
            self.newRound()
        }
    }
    
    func addPlanets() {
//        Add planets
        let positions : [(CGFloat, CGFloat)] = [(100,200), (400,100), (500,300)]
        for pos in positions {
            let planet = Planet(texture: SKTexture(imageNamed: "RedPlanet"), radius: 50, fieldStrength: 2)
            planet.position = CGPointMake(pos.0, pos.1)
            self.planets.append(planet)
            self.addChild(planet)
        }
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
            CGPathMoveToPoint(pathToDraw, nil, currentPlayer!.ball.position.x, currentPlayer!.ball.position.y)
            CGPathAddLineToPoint(pathToDraw, nil, currentPlayer!.ball.position.x + (startPoint.x-endPoint.x), currentPlayer!.ball.position.y + (startPoint.y-endPoint.y))
            
            line.path = pathToDraw
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        var force = CGFloat(-5)
        var shootVector = CGVectorMake(force*(endPoint.x - startPoint.x),force*(endPoint.y - startPoint.y))
        
        currentPlayer!.ball.physicsBody?.applyImpulse(shootVector)
        line.removeFromParent()
        
        self.nextPlayer()
    }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
