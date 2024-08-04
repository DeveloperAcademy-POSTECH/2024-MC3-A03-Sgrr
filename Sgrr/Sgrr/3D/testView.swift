//
//  testView.swift
//  Sgrr
//
//  Created by dora on 7/31/24.
//

import SwiftUI
import PencilKit

struct testView: View {
    @EnvironmentObject var router: Router
    
    @State private var cakeImage: CGImage?
    @Binding var selectedColor: Color
    @State private var showPicker = false
    @State private var currentRotation: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    @State private var currentScale: SIMD3<Float> = SIMD3<Float>(1.0, 1.0, 1.0)
    
    let picker = PKToolPicker()
    var canvasView = PKCanvasView()
    
    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 0){
                ARViewContainer(picker: picker, canvasView: canvasView, currentRotation: $currentRotation, currentScale: $currentScale, cakeImage: $cakeImage, isActive: $showPicker, selectedColor: $selectedColor)
                    .edgesIgnoringSafeArea(.all)
                /// tap시 원 상태로 복귀
                    .gesture(TapGesture().onEnded {
                        currentRotation = SIMD3<Float>(0, 0, 0)
                        currentScale = SIMD3<Float>(1, 1, 1)
                    })
                /// drag시 회전
                    .gesture(DragGesture().onChanged { value in
                        /// 화면상 가로 이동(x좌표 변화) - 3D상 Y축 회전
                        /// 화면상 세로 이동(y좌표 변화) - 3D상 X축 회전
                        let rotationChangeX = Float(value.translation.width) * .pi / 180 * 0.01
                        let rotationChangeY = Float(value.translation.height) * .pi / 180 * 0.01
                        currentRotation.x += rotationChangeY
                        currentRotation.y += rotationChangeX
                    })
                /// pinch시 확대, 축소
                    .gesture(MagnificationGesture().onChanged { value in
                        let pinchScale = Float(value.magnitude)
                        currentScale = SIMD3<Float>(x: pinchScale, y: pinchScale, z: pinchScale)
                    })
                    .frame(height: geometry.size.height / 2.5)
                
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(hex: "#CCC7B4"))
                        .ignoresSafeArea()
                    
                    VStack{
                        CanvasBackgroundView()
                        Spacer().frame(height: 130)
                    }
                    CakeCanvasContainer(canvasView: canvasView, picker: picker, isActive: $showPicker, cakeImage: $cakeImage)
                }
                .frame(height: geometry.size.height / 1.5)
            }
            if !showPicker {
                VStack {
                    Spacer()
                    PhotoPickerCell( images: sampleImages, canvasView: canvasView)
                        .frame(height: 100)
                        .background(Color(hex:"#F4F4F4"))
                }
                .animation(.easeInOut)
                .transition(.move(edge: .bottom))
            }
        }
        .toolbarBackground(Color(hex: "F9F6EB"), for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack {
                    /// 사진 버튼
                    Button(action: {
                        showPicker = false
                    }) {
                        Image(systemName: "photo.on.rectangle")
                            .foregroundColor(Color(hex: "#FA5738"))
                    }
                    /// 그리기 버튼
                    Button(action: {
                        showPicker = true
                    }) {
                        Image(systemName: "pencil.tip.crop.circle")
                            .foregroundColor(Color(hex: "#FA5738"))
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                router.pop()
                                
                            } label: {
                            Image(systemName: "chevron.backward")
                                    .foregroundColor(Color(hex: "FA5738"))
                                    .font(.system(size: 20))
                            }
                        }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    //testView(selectedColor: .yellow)
//}


