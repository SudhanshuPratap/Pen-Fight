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
        spawnPen()

    }
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

        let direction = CGVector(dx: dx / distance, dy: dy / distance)

        let maxForce: CGFloat = 40
        let forceMagnitude = min(distance * 0.1, maxForce)

        let impulse = CGVector(dx: direction.dx * forceMagnitude,
                               dy: direction.dy * forceMagnitude)

        pen.physicsBody?.applyImpulse(impulse)

        
        selectedPen = nil
        touchStartPoint = nil
    }
    override func update(_ currentTime: TimeInterval) {
        checkRingOut()
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
        wallBody.categoryBitMask = PhysicsCategory.wall
        wallBody.collisionBitMask = PhysicsCategory.pen
        wallBody.contactTestBitMask = PhysicsCategory.pen

    }
    
    private func spawnPen() {
        
        let penLength: CGFloat = 120
        let penHeight: CGFloat = 20
        
        let penNode = SKNode()
        penNode.position = CGPoint(x: arenaRect.midX, y: arenaRect.midY)
        
        // Main body
        let bodyNode = SKShapeNode(rectOf: CGSize(width: penLength, height: penHeight), cornerRadius: 10)
        bodyNode.fillColor = SKColor.white
        bodyNode.strokeColor = .clear
        bodyNode.position = .zero
        // Shadow
        let shadowNode = SKShapeNode(rectOf: CGSize(width: penLength, height: penHeight), cornerRadius: 10)
        shadowNode.fillColor = .black
        shadowNode.strokeColor = .clear
        shadowNode.alpha = 0.25
        shadowNode.position = CGPoint(x: 0, y: -6)
        shadowNode.zPosition = -1

        penNode.addChild(shadowNode)


        penNode.addChild(bodyNode)
        
        // Random cap side
        let isCapOnLeft = Bool.random()
        
        let capWidth: CGFloat = 30
        let capNode = SKShapeNode(rectOf: CGSize(width: capWidth, height: penHeight), cornerRadius: 8)
        capNode.fillColor = .blue
        capNode.strokeColor = .clear
        
        let capOffset = (penLength / 2) - (capWidth / 2)
        capNode.position = CGPoint(
            x: isCapOnLeft ? -capOffset : capOffset,
            y: 0
        )
        
        penNode.addChild(capNode)
        
        // Physics body with shifted center of mass
        let massShift: CGFloat = 15
        let centerShift = isCapOnLeft ? -massShift : massShift
        
        penNode.physicsBody = SKPhysicsBody(
            rectangleOf: CGSize(width: penLength, height: penHeight),
            center: CGPoint(x: centerShift, y: 0)
        )
        
        penNode.physicsBody?.mass = 0.4
        penNode.physicsBody?.friction = 0.2
        penNode.physicsBody?.restitution = 0.8
        penNode.physicsBody?.linearDamping = 0.1
        penNode.physicsBody?.angularDamping = 0.4
        penNode.physicsBody?.allowsRotation = true
        
        penNode.physicsBody?.categoryBitMask = PhysicsCategory.pen
        penNode.physicsBody?.collisionBitMask = PhysicsCategory.wall
        penNode.physicsBody?.contactTestBitMask = PhysicsCategory.wall
        
        addChild(penNode)
    }

    private func checkRingOut() {
        guard let pen = children.first(where: { $0.name == nil && $0.physicsBody?.categoryBitMask == PhysicsCategory.pen }) else { return }
        
        if !arenaRect.contains(pen.position) {
            pen.removeFromParent()
            showEliminationEffect(at: pen.position)
        }
    }
    private func showEliminationEffect(at position: CGPoint) {
        let label = SKLabelNode(text: "OUT!")
        label.fontSize = 40
        label.fontColor = .red
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        label.zPosition = 10
        addChild(label)
    }



}
