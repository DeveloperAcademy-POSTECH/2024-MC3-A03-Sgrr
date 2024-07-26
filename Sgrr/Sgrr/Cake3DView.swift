//
//  Cake3DView.swift
//  Sgrr
//
//  Created by dora on 7/25/24.
//

import SwiftUI
import ARKit
import RealityKit

// min, max 크기 제한하기!
// 회전 자연스럽게 고치기..!

let cakeMaterial = SimpleMaterial(color: .systemPink, isMetallic: false)

struct Cake3DView: View {
    
    @State private var currentRotation: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    @State private var currentScale: SIMD3<Float> = SIMD3<Float>(1.0, 1.0, 1.0)
    
    var body: some View {
        ARViewContainer(currentRotation: $currentRotation, currentScale: $currentScale)
            .edgesIgnoringSafeArea(.all)
            .gesture(TapGesture().onEnded {
                // Handle tap gesture here
                print("Tap gesture detected")
            })
            .gesture(DragGesture().onChanged { value in
                // Handle drag gesture here
                let rotationChangeX = Float(value.translation.width) * .pi / 180 * 0.1
                let rotationChangeY = Float(value.translation.height) * .pi / 180 * 0.1
                currentRotation.x += rotationChangeY
                currentRotation.y += rotationChangeX
                print("Drag gesture detected: \(value.translation)")
                
            })
            .gesture(MagnificationGesture().onChanged { value in
                // Handle pinch gesture here
                print("Pinch gesture detected: \(value.magnitude)")
                let pinchScale = Float(value.magnitude)
                currentScale = SIMD3<Float>(x: pinchScale, y: pinchScale, z: pinchScale)
            })
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var currentRotation: SIMD3<Float>
    @Binding var currentScale: SIMD3<Float>

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: true)
        
        let cakeTrayModel = try! ModelEntity.loadModel(named: "cakeTray")
        cakeTrayModel.scale = SIMD3(x: 0.2, y: 0.2, z: 0.2)
        cakeTrayModel.generateCollisionShapes(recursive: true)
        
        let cakeModel = try! ModelEntity.loadModel(named: "cakeModel")
        cakeModel.scale = SIMD3(x: 0.2, y: 0.2, z: 0.2)
        cakeModel.generateCollisionShapes(recursive: true)
        
        let anchor = AnchorEntity(world: [0, 0, 0])
        anchor.addChild(cakeTrayModel)
        anchor.addChild(cakeModel)
        
        arView.scene.anchors.append(anchor)
        
        let camera = PerspectiveCamera()
        let cameraAnchor = AnchorEntity(world: [0, 1.5, 1.5])
        
        let angle = -35.0 * .pi / 180.0
        camera.transform.rotation = simd_quatf(angle: Float(angle), axis: [1, 0, 0])
        
        cameraAnchor.addChild(camera)
        arView.scene.addAnchor(cameraAnchor)
        
        // Store anchor in the context for later updates
        context.coordinator.anchor = anchor
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        guard let anchor = context.coordinator.anchor else { return }
        
        // Apply rotation
        let rotation = simd_quatf(angle: currentRotation.y, axis: [0, 1, 0]) *
                       simd_quatf(angle: currentRotation.x, axis: [1, 0, 0])
        anchor.transform.rotation = rotation
        
        // Apply scale
        anchor.transform.scale = currentScale
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        var anchor: AnchorEntity?
    }
}

#Preview {
    Cake3DView()
}

