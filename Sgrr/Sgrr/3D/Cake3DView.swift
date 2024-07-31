//
//  Cake3DView.swift
//  Sgrr
//
//  Created by dora on 7/25/24.
//

import SwiftUI
import ARKit
import RealityKit

let defaultMaterial = PhysicallyBasedMaterial()

struct Cake3DView: View {
    @State private var currentRotation: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    @State private var currentScale: SIMD3<Float> = SIMD3<Float>(1.0, 1.0, 1.0)
    @Binding var cakeImage: CGImage?

    var body: some View {
        ARViewContainer(currentRotation: $currentRotation, currentScale: $currentScale, cakeImage: $cakeImage)
            .edgesIgnoringSafeArea(.all)
            .gesture(TapGesture().onEnded {
                // Reset rotation and scale on tap
                currentRotation = SIMD3<Float>(0, 0, 0)
                currentScale = SIMD3<Float>(1, 1, 1)
            })
            .gesture(DragGesture().onChanged { value in
                let rotationChangeX = Float(value.translation.width) * .pi / 180 * 0.01
                let rotationChangeY = Float(value.translation.height) * .pi / 180 * 0.01
                currentRotation.x += rotationChangeY
                currentRotation.y += rotationChangeX
            })
            .gesture(MagnificationGesture().onChanged { value in
                let pinchScale = Float(value.magnitude)
                currentScale = SIMD3<Float>(x: pinchScale, y: pinchScale, z: pinchScale)
            })
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var currentRotation: SIMD3<Float>
    @Binding var currentScale: SIMD3<Float>
    @Binding var cakeImage: CGImage?

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: true)
        arView.environment.background = .color(UIColor(Color(hex: "FFF9E1")))
        
        /// 케이크
        let cakeModel = try! ModelEntity.loadModel(named: "cakeModel")
        cakeModel.scale = SIMD3(x: 0.5, y: 0.5, z: 0.5)
        cakeModel.generateCollisionShapes(recursive: true)
        cakeModel.model?.materials = [defaultMaterial]
        
        let cakeTrayModel = try! ModelEntity.loadModel(named: "cakeTray")
        cakeTrayModel.scale = SIMD3(x: 0.5, y: 0.5, z: 0.5)
        cakeTrayModel.generateCollisionShapes(recursive: true)

        let anchor = AnchorEntity(world: [0, 0, 0])
        anchor.addChild(cakeTrayModel)
        anchor.addChild(cakeModel)
        arView.scene.anchors.append(anchor)

        /// 카메라
        let camera = PerspectiveCamera()
        let cameraAnchor = AnchorEntity(world: [0, 1.5, 1.5])
        let angle = -35.0 * .pi / 180.0
        camera.transform.rotation = simd_quatf(angle: Float(angle), axis: [1, 0, 0])
        cameraAnchor.addChild(camera)
        arView.scene.addAnchor(cameraAnchor)

        context.coordinator.anchor = anchor
        context.coordinator.cakeModel = cakeModel

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        guard let anchor = context.coordinator.anchor else { return }

        /// 회전 각도 제한
        let clampedRotationX = max(min(currentRotation.x, 0.3), -0.6)
        let clampedRotationY = max(min(currentRotation.y, 1.2), -7.0)
        let clampedScale = max(min(currentScale.x, 1.6), 0.8)

        let rotation = simd_quatf(angle: clampedRotationY, axis: [0, 1, 0]) *
                       simd_quatf(angle: clampedRotationX, axis: [1, 0, 0])

        anchor.transform.rotation = rotation
        anchor.transform.scale = SIMD3<Float>(repeating: clampedScale)

        if let newImage = cakeImage {
            context.coordinator.updateCakeTexture(cgImage: newImage)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    /// UIKit - SwiftUI 상호작용
    class Coordinator {
        var anchor: AnchorEntity?
        var cakeModel: ModelEntity?

        func updateCakeTexture(cgImage: CGImage) {
            guard let cakeModel = cakeModel else { return }

            do {
                let cakeTexture = try TextureResource.generate(from: cgImage, options: .init(semantic: .color))
                
                var cakeMaterial = PhysicallyBasedMaterial()
                cakeMaterial.baseColor.texture = PhysicallyBasedMaterial.Texture(cakeTexture)
                cakeMaterial.roughness = 0.5
                cakeMaterial.metallic = 0.0
                cakeMaterial.blending = .transparent(opacity: .init(scale: 1))
                
                cakeModel.model?.materials = [cakeMaterial]
            } catch {
                print("Error creating texture: \(error)")
            }
        }
    }
}



