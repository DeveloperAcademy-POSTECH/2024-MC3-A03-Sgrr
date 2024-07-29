//
//  Cake3DView.swift
//  Sgrr
//
//  Created by dora on 7/25/24.
//

import SwiftUI
import ARKit
import RealityKit

///pkcanvasview > cgimage로 뽑아서 material 씌울 예정
let cakeMaterial = SimpleMaterial(color: .systemPink, isMetallic: false)

struct Cake3DView: View {
    
    @State private var currentRotation: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    @State private var currentScale: SIMD3<Float> = SIMD3<Float>(1.0, 1.0, 1.0)
    
    var body: some View {
        ARViewContainer(currentRotation: $currentRotation, currentScale: $currentScale)
            .edgesIgnoringSafeArea(.all)
            .gesture(TapGesture().onEnded {
                ///tap하면 원래로 돌아오게!
                currentRotation = SIMD3<Float>(0,0,0)
                currentScale = SIMD3<Float>(1,1,1)
                
            })
            .gesture(DragGesture().onChanged { value in
                let rotationChangeX = Float(value.translation.width) * .pi / 180 * 0.01
                let rotationChangeY = Float(value.translation.height) * .pi / 180 * 0.01
                currentRotation.x += rotationChangeY
                currentRotation.y += rotationChangeX
                
                print("rotation은 + \(currentRotation)")
            })
            .gesture(MagnificationGesture().onChanged { value in
                let pinchScale = Float(value.magnitude)
                currentScale = SIMD3<Float>(x: pinchScale, y: pinchScale, z: pinchScale)
                
                print("scale은 + \(pinchScale)")
            })
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var currentRotation: SIMD3<Float>
    @Binding var currentScale: SIMD3<Float>

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: true)
        
        let cakeTrayModel = try! ModelEntity.loadModel(named: "cakeTray")
        cakeTrayModel.scale = SIMD3(x: 0.3, y: 0.3, z: 0.3)
        cakeTrayModel.generateCollisionShapes(recursive: true)
        
        let cakeModel = try! ModelEntity.loadModel(named: "cakeModel")
        cakeModel.scale = SIMD3(x: 0.3, y: 0.3, z: 0.3)
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
        
        context.coordinator.anchor = anchor
        
        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        guard let anchor = context.coordinator.anchor else { return }
        
        let clampedRotationX = max(min(currentRotation.x, 0.3), -0.6)
        let clampedRotationY = max(min(currentRotation.y, 1.2), -7.0)
        let clampedScale = max(min(currentScale.x, 1.6), 0.8)
        
        let rotation = simd_quatf(angle: clampedRotationY, axis: [0, 1, 0]) *
                       simd_quatf(angle: clampedRotationX, axis: [1, 0, 0])
        
        anchor.transform.rotation = rotation
        anchor.transform.scale = SIMD3<Float>(repeating: clampedScale)
    }
    
    /// UIKit, SwiftUI 연동을 위함
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



