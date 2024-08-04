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
    
    ///picker표시
    @Binding var isActive: Bool
    
    ///배경색 선택
    @Binding var selectedColor: Color
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: true)
        arView.environment.background = .color(UIColor(Color(hex: "FFF9E1")))
        
        let selectedMaterial = SimpleMaterial(color: UIColor(selectedColor), isMetallic: false)
        
        /// 케이크 재질 입힐 것
        let cakeModel = try! ModelEntity.loadModel(named: "cakeModel")
        cakeModel.scale = SIMD3(x: 0.54, y: 0.54, z: 0.54)
        cakeModel.generateCollisionShapes(recursive: true)
        cakeModel.model?.materials = [selectedMaterial]
        
        /// 기본 케이크
        let cakeDefaultModel = try! ModelEntity.loadModel(named: "cakeModel")
        cakeDefaultModel.scale = SIMD3(x: 0.539, y: 0.539, z: 0.539)
        cakeDefaultModel.generateCollisionShapes(recursive: true)
        cakeDefaultModel.model?.materials = [selectedMaterial]
        
        let cakeTrayModel = try! ModelEntity.loadModel(named: "cakeTray")
        cakeTrayModel.scale = SIMD3(x: 0.54, y: 0.54, z: 0.54)
        cakeTrayModel.generateCollisionShapes(recursive: true)
        
        let anchor = AnchorEntity(world: [0, 0.1, 0])
        anchor.addChild(cakeTrayModel)
        anchor.addChild(cakeDefaultModel)
        anchor.addChild(cakeModel)
        arView.scene.anchors.append(anchor)
        
        /// 카메라
        let camera = PerspectiveCamera()
        let cameraAnchor = AnchorEntity(world: [0, 1.4, 1.5])
        
        let angle = -35.0 * .pi / 180.0
        camera.transform.rotation = simd_quatf(angle: Float(angle), axis: [1, 0, 0])
        cameraAnchor.addChild(camera)
        arView.scene.addAnchor(cameraAnchor)
        
        context.coordinator.anchor = anchor
        context.coordinator.cakeModel = cakeModel
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
//        picker.setVisible(isActive, forFirstResponder: uiView)
//        
//        DispatchQueue.main.async {
//            uiView.becomeFirstResponder()
//        }
        
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

            // 이미지 크기와 비트맵 정보를 가져옵니다.
            let width = cgImage.width
            let height = cgImage.height
            let bitsPerComponent = cgImage.bitsPerComponent
            let bytesPerRow = cgImage.bytesPerRow
            let colorSpace = cgImage.colorSpace ?? CGColorSpace(name: CGColorSpace.sRGB)!
            let bitmapInfo = cgImage.bitmapInfo

            // 추가로 이동할 y 축 오프셋
            let additionalOffset: CGFloat = 50 // 원하는 만큼의 이동 값

            // 회전된 이미지 컨텍스트 생성
            guard let context = CGContext(
                data: nil,
                width: width,
                height: height,
                bitsPerComponent: bitsPerComponent,
                bytesPerRow: bytesPerRow,
                space: colorSpace,
                bitmapInfo: bitmapInfo.rawValue
            ) else {
                print("Error creating CGContext")
                return
            }

            // 이미지 이동 및 회전 설정
            context.translateBy(x: CGFloat(width) / 2, y: CGFloat(height) / 2)
            context.rotate(by: 30 * .pi / 180)
            context.translateBy(x: -CGFloat(width) / 2, y: -CGFloat(height) / 2 - additionalOffset)

            // y 축 플립
            context.translateBy(x: 0, y: CGFloat(height))
            context.scaleBy(x: 1.0, y: -1.0)

            // 이미지를 컨텍스트에 그립니다.
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))

            // 플립된 이미지를 생성합니다.
            guard let flippedImage = context.makeImage() else {
                print("Error creating flipped CGImage")
                return
            }

            // 플립된 이미지를 텍스처로 사용
            do {
                let cakeTexture = try TextureResource.generate(from: flippedImage, options: .init(semantic: .color))

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


