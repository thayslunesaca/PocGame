//
//  GameScene.swift
//  POCGame
//
//  Created by Milena Lima de Alcântara on 23/03/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: Properties
    var ground: SKSpriteNode!
    var player: SKSpriteNode!
    var cameraNode = SKCameraNode()
    
    var cameraMovePointPerSecond: CGFloat = 450.0
    
    var lastUpdateTime: TimeInterval = 0.0
    var dt: TimeInterval = 0.0
    
    var playableRect: CGRect {
        let ratio: CGFloat
        switch UIScreen.main.nativeBounds.height {
        case 2688,1792,2436:
            ratio = 2.16
        default:
            ratio = 16/9
        }
        let playableHeight = size.width / ratio
        let playableMargin = (size.height - playableHeight) / 2.0
        
        return CGRect (x: 0.0, y: playableMargin, width: size.width,height:  playableHeight)
    }
    var cameraRect: CGRect {
        let width = playableRect.width
        let height = playableRect.height
        let x = cameraNode.position.x - size.width/2.0 + (size.width - width)/2.0
        let y = cameraNode.position.y - size.height/2.0 + (size.height - height)/2.0
        
        return CGRect (x:x, y: y, width: width, height:height)

    }
    
    var onGround = true
    var velocityY: CGFloat = 0.0
    var gravity: CGFloat = 0.6
    var playerPosY: CGFloat = 0.0
    
    // MARK: Systems
    
    override func didMove(to view: SKView) {
        setupNodes()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
//        moveCamera()
        velocityY += gravity
        player.position.y -= velocityY
        
        if player.position.y < playerPosY {
            player.position.y = playerPosY
            velocityY = 0.0
            onGround = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if onGround {
            onGround = false
            velocityY = -25.0
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if velocityY < -12.5 {
            velocityY = -12.5
        }
    }
}

// MARK: Configurations

extension GameScene {
    
    func setupNodes() {
        createBG()
        createGround()
        createPlayer()
//        setupCamera()
    }
    
    func createBG() {
        for i in 0...2 {
            let bg = SKSpriteNode(imageNamed: "background")
            bg.name = "BG"
            bg.anchorPoint = .zero
            bg.position = CGPoint(x: CGFloat(i)*bg.frame.width,y:0.0)
            bg.zPosition = -1.0
            addChild(bg)
        }
    }
    
    func createGround() {
        for i in 0...2 {
            let ground = SKSpriteNode(imageNamed: "ground")
            ground.name = "Ground"
            ground.anchorPoint = .zero
            ground.zPosition = 1.0
            ground.position = CGPoint(x: CGFloat(i) * ground.frame.width, y: 0.0)
            addChild(ground)
        }
    }
    
    func createPlayer() {
        player = SKSpriteNode(imageNamed: "ninja")
        player.name = "Ninja"
        player.zPosition = 5.0
        player.position = CGPoint(
            x: frame.width/2.0 - 100.0,
            y: player.frame.height * 1.1)
        playerPosY = player.position.y
        addChild(player)
    }
    
//    func setupCamera(){
//        addChild(cameraNode)
//        camera = cameraNode
//        cameraNode.position = CGPoint(x: frame.midX, y: frame.midY)
//    }
    
//    func moveCamera() {
//        let amountToMove = CGPoint(x: cameraMovePointPerSecond *
//                                   CGFloat(dt), y: 0.0)
//        cameraNode.position += amountToMove
//
//        // BACKGROUND
//        enumerateChildNodes(withName: "BG") {(node, _) in
//            let node = node as! SKSpriteNode
//
//            if node.position.x + node.frame.width < self.cameraRect.origin.x {
//                node.position = CGPoint(x: node.position.x + node.frame.width*2.0,y: node.position.y)
//            }
//
//        }
//        //GROUND
//        enumerateChildNodes(withName: "Ground") {(node, _) in
//            let node = node as! SKSpriteNode
//
//            if node.position.x + node.frame.width < self.cameraRect.origin.x {
//                node.position = CGPoint(x: node.position.x + node.frame.width*2.0,y: node.position.y)
//            }
//
//        }
//
//    }
    
}
