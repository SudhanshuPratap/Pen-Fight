//
//  GameScene.swift
//  Pen Fight
//
//  Created by Sudhanshu on 17/02/26.
//
import SpriteKit

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let pen: UInt32 = 0b1
    static let wall: UInt32 = 0b10
}

class GameScene: SKScene {
    
    private var arenaRect: CGRect = .zero
    private var selectedPen: SKNode?
    private var touchStartPoint: CGPoint?
    
    override func didMove(to view: SKView) {
        backgroundColor = .black
        physicsWorld.gravity = .zero
        
        setupArena()
        setupTopWall()
        view.showsPhysics = true

        // Spawn two pens (duel setup)
        spawnPen(at: CGPoint(x: arenaRect.midX, y: arenaRect.midY + 80))
        spawnPen(at: CGPoint(x: arenaRect.midX, y: arenaRect.midY - 80))
    }
    
    // MARK: - Touch Handling
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if let node = nodes(at: location).first?.parent,
           node.physicsBody?.categoryBitMask == PhysicsCategory.pen {
            selectedPen = node
            touchStartPoint = location
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first,
              let start = touchStartPoint,
              let pen = selectedPen else { return }
        
        let end = touch.location(in: self)
        
        let dx = end.x - start.x
        let dy = end.y - start.y
        let distance = sqrt(dx * dx + dy * dy)
        
        guard distance > 0 else { return }
        
        let direction = CGVector(dx: dx / distance, dy: dy / distance)
        
        let maxForce: CGFloat = 35
        let forceMagnitude = min(distance * 0.14, maxForce)

        
        let impulse = CGVector(
            dx: direction.dx * forceMagnitude,
            dy: direction.dy * forceMagnitude
        )
        
        // 🔥 Realistic torque application
        pen.physicsBody?.applyImpulse(impulse, at: start)
        
        selectedPen = nil
        touchStartPoint = nil
    }
    
    override func update(_ currentTime: TimeInterval) {
        checkRingOut()
    }
    
    // MARK: - Arena Setup
    
    private func setupArena() {
        let width = size.width * 0.9
        let height = size.height * 0.7

        
        let originX = (size.width - width) / 2
        let originY = (size.height - height) / 2
        
        arenaRect = CGRect(x: originX, y: originY, width: width, height: height)
        
        let arenaNode = SKShapeNode(rect: arenaRect)
        arenaNode.strokeColor = .white
        arenaNode.lineWidth = 4
        arenaNode.fillColor = SKColor(white: 0.15, alpha: 1) // Desk surface
        
        addChild(arenaNode)
    }
    
    private func setupTopWall() {
        let topLeft = CGPoint(x: arenaRect.minX, y: arenaRect.maxY)
        let topRight = CGPoint(x: arenaRect.maxX, y: arenaRect.maxY)
        
        let wallBody = SKPhysicsBody(edgeFrom: topLeft, to: topRight)
        wallBody.friction = 0.6
        wallBody.restitution = 0.1
        
        wallBody.categoryBitMask = PhysicsCategory.wall
        wallBody.collisionBitMask = PhysicsCategory.pen
        wallBody.contactTestBitMask = PhysicsCategory.pen
        
        let wallNode = SKNode()
        wallNode.physicsBody = wallBody
        
        addChild(wallNode)
    }
    
    // MARK: - Pen
    
    private func spawnPen(at position: CGPoint) {
        
        let penLength: CGFloat = 90
        let penHeight: CGFloat = 16
        
        let penNode = SKNode()
        penNode.position = position
        
        // MARK: Shadow
        
        let shadowNode = SKShapeNode(
            rectOf: CGSize(width: penLength, height: penHeight),
            cornerRadius: penHeight / 2
        )
        shadowNode.fillColor = .black
        shadowNode.strokeColor = .clear
        shadowNode.alpha = 0.18
        shadowNode.position = CGPoint(x: 0, y: -4)
        shadowNode.zPosition = -1
        penNode.addChild(shadowNode)
        
        // MARK: Visual Body (Capsule Look)
        
        let bodyNode = SKShapeNode(
            rectOf: CGSize(width: penLength, height: penHeight),
            cornerRadius: penHeight / 2
        )
        bodyNode.fillColor = .white
        bodyNode.strokeColor = .darkGray
        bodyNode.lineWidth = 1
        penNode.addChild(bodyNode)
        
        // MARK: Random Cap
        
        let isCapOnLeft = Bool.random()
        let capWidth: CGFloat = 23
        
        let capNode = SKShapeNode(
            rectOf: CGSize(width: capWidth, height: penHeight),
            cornerRadius: penHeight / 2
        )
        capNode.fillColor = .blue
        capNode.strokeColor = .clear
        
        let capOffset = (penLength / 2) - (capWidth / 2)
        capNode.position = CGPoint(
            x: isCapOnLeft ? -capOffset : capOffset,
            y: 0
        )
        
        penNode.addChild(capNode)
        
        // MARK: Capsule Physics (Proper)
        
        let massShift: CGFloat = 18
        let shift = isCapOnLeft ? -massShift : massShift
        
        let coreRect = SKPhysicsBody(
            rectangleOf: CGSize(width: penLength - penHeight, height: penHeight),
            center: CGPoint(x: shift, y: 0)
        )
        
        let leftCircle = SKPhysicsBody(
            circleOfRadius: penHeight / 2,
            center: CGPoint(x: -(penLength - penHeight)/2 + shift, y: 0)
        )
        
        let rightCircle = SKPhysicsBody(
            circleOfRadius: penHeight / 2,
            center: CGPoint(x: (penLength - penHeight)/2 + shift, y: 0)
        )
        
        let compoundBody = SKPhysicsBody(bodies: [coreRect, leftCircle, rightCircle])
        
        compoundBody.mass = 0.22
        compoundBody.friction = 0.8
        compoundBody.restitution = 0.1
        compoundBody.linearDamping = 0.25
        compoundBody.angularDamping = 0.5
        compoundBody.allowsRotation = true
        
        compoundBody.categoryBitMask = PhysicsCategory.pen
        compoundBody.collisionBitMask =
            PhysicsCategory.wall | PhysicsCategory.pen
        compoundBody.contactTestBitMask =
            PhysicsCategory.wall | PhysicsCategory.pen
        
        penNode.physicsBody = compoundBody
        
        addChild(penNode)
    }

    
    private func showEliminationEffect() {
        let label = SKLabelNode(text: "OUT!")
        label.fontSize = 40
        label.fontColor = .red
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        label.zPosition = 10
        addChild(label)
    }
}
