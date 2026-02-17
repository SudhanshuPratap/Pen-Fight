//
//  GameScene.swift
//  Pen Fight
//
//  Created by Sudhanshu on 17/02/26.
//
import SpriteKit

class GameScene: SKScene {
    
    private var arenaRect: CGRect = .zero
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        physicsWorld.gravity = .zero
        
        setupArena()
        setupTopWall()
    }
    
    private func setupArena() {
        let width = size.width * 0.8
        let height = size.height * 0.6
        
        let originX = (size.width - width) / 2
        let originY = (size.height - height) / 2
        
        arenaRect = CGRect(x: originX, y: originY, width: width, height: height)
        
        let arenaNode = SKShapeNode(rect: arenaRect)
        arenaNode.strokeColor = .white
        arenaNode.lineWidth = 4
        arenaNode.fillColor = .clear
        
        addChild(arenaNode)
    }
    
    private func setupTopWall() {
        let topLeft = CGPoint(x: arenaRect.minX, y: arenaRect.maxY)
        let topRight = CGPoint(x: arenaRect.maxX, y: arenaRect.maxY)
        
        let wallBody = SKPhysicsBody(edgeFrom: topLeft, to: topRight)
        wallBody.friction = 0.2
        wallBody.restitution = 0.8
        
        let wallNode = SKNode()
        wallNode.physicsBody = wallBody
        
        addChild(wallNode)
    }
}
