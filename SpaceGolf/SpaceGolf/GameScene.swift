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
    
    var planets : [Planet] = []
    
    var line = SKShapeNode();
    
    var currentPlayerLabel : SKLabelNode = SKLabelNode()
    
    var game : Game?
    var currentPlayer : Player? {
        didSet {
            self.currentPlayerLabel.text = self.currentPlayer!.name + ":\t" + "\(currentPlayer!.score)"
        }
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
//        TODO: Should be a partog AddPlayerVC
        self.physicsWorld.contactDelegate = self
        
        
        self.currentPlayerLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode(rawValue: 1)!
        self.currentPlayerLabel.position = CGPointMake(10, self.view!.frame.height-20)
        self.currentPlayerLabel.fontName = "Space Comics"
        self.currentPlayerLabel.fontSize = 12
        self.addChild(self.currentPlayerLabel)
        
        let boxMargin : CGFloat = 400
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: CGRectMake(-boxMargin, -boxMargin, self.frame.width+boxMargin*2, self.frame.height+boxMargin*2))
        
        let backgroundSprite = SKSpriteNode(imageNamed: "gameBackground")
        backgroundSprite.position = CGPointMake(self.size.width/2, self.size.height/2)
        self.insertChild(backgroundSprite, atIndex: 0)
        backgroundSprite.zPosition = -1
        
        self.addPlanets()
        self.newRound()
        
        self.addChild(self.line)
        self.line.zPosition = 10
    }

//    TODO: Should update map
    func newRound() {
        
        self.game?.newRound()
        
        for player in self.game!.players {
            let physicsBody = player.ball.physicsBody
            player.ball.physicsBody = nil
            
//          TODO: Should be assigned to a given start point?
            player.ball.position = CGPoint(x: 100, y: 100)
            player.ball.physicsBody = physicsBody
            player.ball.physicsBody?.dynamic = true
        }
        
        self.nextPlayer()
    }
    
    func nextPlayer() {
        self.currentPlayer?.changeScore(1)
        
        self.currentPlayer = self.game?.nextPlayer()
        
        if self.currentPlayer?.ball.parent == nil {
            self.addChild(self.currentPlayer!.ball)
        }
    }
    
//    TODO: Should be found in map class?
    func addPlanets() {
        for planet in self.planets {
            planet.removeFromParent()
        }
        self.planets = []
        
//        Add planets
        let planetNames = ["RedPlanet", "GreenPlanet", "BluePlanet"]
        let positions : [(CGFloat, CGFloat)] = [(0.15,0.5), (0.55,0.25), (0.85,0.6)]
        for (i, pos) in enumerate(positions) {
            let planet = Planet(texture: SKTexture(imageNamed: planetNames[i%planetNames.count]), radius: self.frame.height*0.15, fieldStrength: 2)
            planet.position = CGPointMake(pos.0 * self.frame.width, pos.1 * self.frame.height)
            self.planets.append(planet)
            self.addChild(planet)
        }
        
        self.planets[(Int(rand())%self.planets.count)].state = .Hole
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            startPoint = touch.locationInNode(self)
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            endPoint = touch.locationInNode(self)
            
            let pathToDraw = CGPathCreateMutable()

            CGPathMoveToPoint(pathToDraw, nil, currentPlayer!.ball.position.x, currentPlayer!.ball.position.y)
            CGPathAddLineToPoint(pathToDraw, nil, currentPlayer!.ball.position.x + (startPoint.x-endPoint.x), currentPlayer!.ball.position.y + (startPoint.y-endPoint.y))
            
            line.path = pathToDraw
        }
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        let emptyPath = CGPathCreateMutable()
        
        CGPathMoveToPoint(emptyPath, nil, currentPlayer!.ball.position.x, currentPlayer!.ball.position.y)
        
        line.path = emptyPath
        
//        Preven player from shooting before te ball is relatively static
//        if self.sizeOfVector(currentPlayer!.ball.physicsBody!.velocity) > 4 {
//            return
//        }
        
        var force = CGFloat(-5)
        var shootVector = CGVectorMake(force*(endPoint.x - startPoint.x),force*(endPoint.y - startPoint.y))
        
        GameSounds.sharedInstance.playEffectSoundWithName("hitBall", ofType: "mp3")
        currentPlayer!.ball.physicsBody?.applyImpulse(shootVector)
        self.nextPlayer()
    }
    
    private func sizeOfVector(vector: CGVector) -> CGFloat {
        return sqrt(pow(vector.dx,2) + pow(vector.dy,2))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var ball : Ball? = ballDidHitPlanet(contact).0
        var planet : Planet? = ballDidHitPlanet(contact).1

        if (ball != nil || planet != nil){
            if planet!.isInTheHole(ball!) {
                
                GameSounds.sharedInstance.playEffectSoundWithName("hitHole", ofType: "mp3")
                
                self.game?.playerIsDone(self.game!.playerForBall(ball!)!)
                ball!.physicsBody?.dynamic = false
                ball!.removeFromParent()
                
                if self.game!.roundIsDone() {
                    let fvc = ((UIApplication.sharedApplication().delegate as! AppDelegate).window!.rootViewController! as! UINavigationController).viewControllers.last! as! GameViewController
                    fvc.performSegueWithIdentifier("ShowGameFinished", sender: nil)
                    //Kall på gamefinished screen
                }
            }
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
