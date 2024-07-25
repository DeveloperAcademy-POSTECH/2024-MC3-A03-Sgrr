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
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero, cameraMode: .nonAR, automaticallyConfigureSession: true)
        
        let cakeTrayModel = try! ModelEntity.loadModel(named: "cakeTray")
        cakeTrayModel.scale = SIMD3(x: 0.2, y: 0.2, z: 0.2)
        cakeTrayModel.generateCollisionShapes(recursive: true)
        
        let cakeModel = try! ModelEntity.loadModel(named: "cakeModel")
        cakeModel.scale = SIMD3(x: 0.2, y: 0.2, z: 0.2)
        cakeModel.generateCollisionShapes(recursive: true)
        
        // Create a cube model
        //        let mesh = MeshResource.generateBox(size: 0.1, cornerRadius: 0.005)
        //        let material = SimpleMaterial(color: .gray, roughness: 0.15, isMetallic: true)
        //        let model = ModelEntity(mesh: mesh, materials: [material])
        
        // Create world anchor at the origin
        let anchor = AnchorEntity(world: [0, 0, 0])
        anchor.addChild(cakeTrayModel)
        anchor.addChild(cakeModel)
        
        // Add the anchor to the scene
        arView.scene.anchors.append(anchor)
        
        // 시간흐르게 하는 코드 확인 필요
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            cakeModel.model?.materials = [cakeMaterial]
        }
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
}

#Preview {
    Cake3DView()
}
