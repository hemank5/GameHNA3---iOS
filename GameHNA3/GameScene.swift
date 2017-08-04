//
//  GameScene.swift
//  GameHNA3
//
//  Created by Hemank Narula on 5/13/17.
//  Copyright © 2017 Hemank. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let manager = CMMotionManager() //starts measuring data immediately
    var player = SKSpriteNode()
    var endNode = SKSpriteNode()
    let scoreNode = SKSpriteNode()
    var score = Int() //for score
    let scoreLbl = SKLabelNode()
    var died = Bool()
    var win = Bool()
    var gameover = SKSpriteNode()
    var youwin = SKSpriteNode()
    var gameStarted = Bool()

    
    
    func createScene()
    {
        self.physicsWorld.contactDelegate = self
        
       
        //for setting the position of score label on the scene
        scoreLbl.position = CGPoint(x: self.frame.width / 3, y: self.frame.height / 2.5 )
        scoreLbl.text = "\(score)"
        self.addChild(scoreLbl)
        scoreLbl.fontColor = UIColor.black //font color which we used for displaying on the scene
        scoreLbl.fontSize = 80
        scoreLbl.fontName = "Arial"
    
        // setting the position of label , setting ordering
        scoreLbl.zPosition = 5
        
        
        player = self.childNode(withName: "player") as! SKSpriteNode
        
        endNode = self.childNode(withName: "endNode") as! SKSpriteNode
        
        // from here we are starting the accelerometer
        manager.startMagnetometerUpdates()
        manager.accelerometerUpdateInterval = 0.1
        manager.startAccelerometerUpdates(to: OperationQueue.main)
        {
            //this will hold the data from the accelerometer
            (data, error) in
            
            //start moving your object
            self.physicsWorld.gravity = CGVector(dx: CGFloat((data?.acceleration.x)!) * 10, dy: CGFloat((data?.acceleration.y)!) * 10)
            
        }

    
    }
    
    override func didMove(to view: SKView)
            {

            createScene()
            }
    
    
    func gameOver(){
        
        gameover = SKSpriteNode(imageNamed: "Game_Over.jpg")
        gameover.size = CGSize(width: 500, height: 200)
        gameover.position = CGPoint(x: self.frame.width / 14, y : self.frame.height / 12) //setting the position on the scene
        gameover.zPosition = 6 //setting the ordering of the scene
        gameover.setScale(0)
        self.addChild(gameover) //for displaying on the scene
        
        gameover.run(SKAction.scale(to: 1.0, duration:0.3))
    }
    
    func youWin(){
        youwin = SKSpriteNode(imageNamed: "you-win.png")
        youwin.size = CGSize(width: 991, height: 473)
        youwin.position = CGPoint(x: self.frame.width / 14, y : self.frame.height / 12) //setting the position on the scene
        youwin.zPosition = 6 //setting the ordering of the scene
        youwin.setScale(0)
        self.addChild(youwin) //for displaying on the scene
        
        youwin.run(SKAction.scale(to: 1.0, duration:0.3))
    
    }
    
    func breakBlock(node: SKNode) {
        let particles = SKEmitterNode()
        particles.position = node.position
        particles.zPosition = 3
        addChild(particles)
        particles.run(SKAction.sequence([SKAction.wait(forDuration: 1.0),
                                         SKAction.removeFromParent()]))
        node.removeFromParent()
    }

    func didBegin(_ contact: SKPhysicsContact)
    {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 3 || bodyA.categoryBitMask == 3 && bodyB.categoryBitMask == 1
        {
            
            
            score += 1
            print(score)
            
            //for printing score on screen
            scoreLbl.text = "\(score)"
            
            breakBlock(node: bodyA.node!)
            
        
            
        }
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 2 || bodyA.categoryBitMask == 2 && bodyB.categoryBitMask == 1
        {
            
            died = true
            gameOver()
            player.physicsBody?.affectedByGravity = false
            player.physicsBody?.allowsRotation = false
            player.physicsBody?.isDynamic = false
            
            
            
        }
        
        if bodyA.categoryBitMask == 1 && bodyB.categoryBitMask == 4 || bodyA.categoryBitMask == 4 && bodyB.categoryBitMask == 1
        {
            
            win = true
            youWin()
            player.physicsBody?.affectedByGravity = false
            player.physicsBody?.allowsRotation = false
            player.physicsBody?.isDynamic = false
            
        }
        
        
    }

    //on touch event which will make the ball jump while tapping on the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        if died == true
        {
        
            }
        else{
        player.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        player.physicsBody?.applyImpulse(CGVector(dx:0, dy: 150))
        }
        
        
        

    }
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
