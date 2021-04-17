//
//  Plane.swift
//  AircraftHunter
//
//  Created by Gustavo A Ramírez Franco on 12/4/21.
//

import ARKit

class Plane: SCNNode {
    let speed: Float = 9
    
    override init() {
        super.init()

        let scene = SCNScene(named: "ship.scn")
        guard let plane = scene?.rootNode.childNode(withName: "ship", recursively: true) else { return }

        self.addChildNode(plane)

        self.transform.m41 = Float.random(in: -1...1) // X
        self.transform.m42 = Float.random(in: -1...1) // Y
        self.transform.m43 = Float.random(in: -1.5 ... -1) // Z

        let shape = SCNPhysicsShape(geometry: SCNBox(width: 0.67, height: 0.17, length: 0.4, chamferRadius: 0), options: nil)

        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: shape)
        self.physicsBody?.isAffectedByGravity = false

        self.physicsBody?.categoryBitMask = Collisions.plane.rawValue
        self.physicsBody?.collisionBitMask = Collisions.bullet.rawValue        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func face(to cameraOrientation: simd_float4x4) {
        var transform = cameraOrientation
        transform.columns.3.x = self.position.x
        transform.columns.3.y = self.position.y
        transform.columns.3.z = self.position.z
        self.transform = SCNMatrix4(transform)
    }
    
    func move(_ camera: ARCamera) {
        let matrix = SCNMatrix4(camera.transform)
        let v = -speed
        let dir = SCNVector3(v * matrix.m31, v * matrix.m32, v * matrix.m33)
        self.physicsBody?.applyForce(dir, asImpulse: true)
    }
}
