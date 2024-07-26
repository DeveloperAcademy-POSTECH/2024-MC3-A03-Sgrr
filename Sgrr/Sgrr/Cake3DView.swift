//
//  Cake3DView.swift
//  Sgrr
//
//  Created by dora on 7/25/24.
//

import SwiftUI
import ARKit
import RealityKit

let cakeMaterial = SimpleMaterial(color: .systemPink, isMetallic: false)

struct Cake3DView: View {
    
    @State private var currentRotation: Float = 0.0
    
    var body: some View {
        ARViewContainer(currentRotation: $currentRotation).edgesIgnoringSafeArea(.all)
            .gesture(TapGesture().onEnded {
                // Handle tap gesture here
                print("Tap gesture detected")
            })
            .gesture(DragGesture().onChanged { value in
                // Handle drag gesture here
                let rotationChange = Float(value.translation.width) * .pi / 180
                currentRotation += rotationChange
                print("Drag gesture detected: \(value.translation)")
                
            })
            .gesture(MagnificationGesture().onChanged { value in
                // Handle pinch gesture here
                print("Pinch gesture detected: \(value.magnitude)")
            })
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var currentRotation: Float

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
        anchor.transform.rotation = simd_quatf(angle: currentRotation, axis: [0, 1, 0])
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
