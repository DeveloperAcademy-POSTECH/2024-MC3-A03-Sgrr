//
//  Cake3DView.swift
//  Sgrr
//
//  Created by dora on 7/25/24.
//

import SwiftUI
import ARKit
import RealityKit
import PencilKit

let defaultMaterial = PhysicallyBasedMaterial()


struct ARViewContainer: UIViewRepresentable {
    let picker: PKToolPicker
    let canvasView: PKCanvasView
    
    @Binding var currentRotation: SIMD3<Float>
    @Binding var currentScale: SIMD3<Float>
    @Binding var cakeImage: CGImage?
    @Binding var isActive: Bool
    @Binding var selectedColor: Color

    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: true)
        arView.environment.background = .color(UIColor(Color(hex: "FFF9E1")))
        
        let selectedMaterial = SimpleMaterial(color: UIColor(selectedColor), isMetallic: false)
        
        /// 케이크
        let cakeModel = try! ModelEntity.loadModel(named: "cakeModel")
        cakeModel.scale = SIMD3(x: 0.55, y: 0.55, z: 0.55)
        cakeModel.generateCollisionShapes(recursive: true)
        cakeModel.model?.materials = [selectedMaterial]
        
        let cakeDefaultModel = try! ModelEntity.loadModel(named: "cakeModel")
        cakeDefaultModel.scale = SIMD3(x: 0.549, y: 0.549, z: 0.549)
        //cakeDefaultModel.generateCollisionShapes(recursive: true)
        /// 선택색으로 기본색 설정
        cakeDefaultModel.model?.materials = [selectedMaterial]
        
        
        let cakeTrayModel = try! ModelEntity.loadModel(named: "cakeTray")
        cakeTrayModel.scale = SIMD3(x: 0.55, y: 0.55, z: 0.55)
        cakeTrayModel.generateCollisionShapes(recursive: true)

        let anchor = AnchorEntity(world: [0, 0, 0])
        anchor.addChild(cakeTrayModel)
        anchor.addChild(cakeDefaultModel)
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
        // PKToolPicker 설정
        if let window = uiView.window {
            picker.setVisible(isActive, forFirstResponder: canvasView)
            picker.addObserver(canvasView)
            picker.setVisible(true, forFirstResponder: canvasView)
            canvasView.becomeFirstResponder()
        }
        
        DispatchQueue.main.async {
            uiView.becomeFirstResponder()
        }
        
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




