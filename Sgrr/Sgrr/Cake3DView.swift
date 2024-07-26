//
//  Cake3DView.swift
//  Sgrr
//
//  Created by dora on 7/25/24.
//

import SwiftUI
import ARKit
import RealityKit

// 회전 방향 수정!
// 최대 크기, 최저 크기, 최대 회전 수정하기

let cakeMaterial = SimpleMaterial(color: .systemPink, isMetallic: false)

let minRotation = SIMD3<Float>(0.0, 0.0, 0.0)
let maxRotation = SIMD3<Float>(0.0, 0.0, 0.0)

let minScale = SIMD3<Float>(0.0, 0.0, 0.0)
let maxScale = SIMD3<Float>(0.0, 0.0, 0.0)

struct Cake3DView: View {
    
    @State private var currentRotation: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    @State private var currentScale: SIMD3<Float> = SIMD3<Float>(1.0, 1.0, 1.0)
    
    var body: some View {
        ARViewContainer(currentRotation: $currentRotation, currentScale: $currentScale)
            .edgesIgnoringSafeArea(.all)
            .gesture(TapGesture().onEnded {
                currentRotation = SIMD3<Float>(0,0,0)
                currentScale = SIMD3<Float>(1,1,1)
            })
            .gesture(DragGesture().onChanged { value in
                let rotationChangeX = Float(value.translation.width) * .pi / 180 * 0.01
                let rotationChangeY = Float(value.translation.height) * .pi / 180 * 0.01
                currentRotation.x += rotationChangeY
                currentRotation.y += rotationChangeX
                //print("currentRotation X: + \(currentRotation.x) +, currentRotation Y: \(currentRotation.y)")
            })
            .gesture(MagnificationGesture().onChanged { value in
                let pinchScale = Float(value.magnitude)
                currentScale = SIMD3<Float>(x: pinchScale, y: pinchScale, z: pinchScale)
                //print("currentScale + \(currentScale)")
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
        
        
        let rotation = simd_quatf(angle: currentRotation.y, axis: [0, 1, 0]) *
                       simd_quatf(angle: currentRotation.x, axis: [1, 0, 0])
        

        
        anchor.transform.rotation = rotation
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

