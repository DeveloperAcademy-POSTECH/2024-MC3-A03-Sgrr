//
//  testView.swift
//  Sgrr
//
//  Created by dora on 7/31/24.
//

import SwiftUI
import PencilKit

struct CakeView: View {
    @EnvironmentObject var router: Router
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(
        entity: OrderForm.entity(),
        sortDescriptors: []
    ) private var orderForms: FetchedResults<OrderForm>
    
    var orderForm: OrderForm {
        guard let order = orderForms.last else {
            return OrderForm()
        }
        return order
    }
    
    var sampleImages: [UIImage] {
        var images: [UIImage] = []

        // Safely unwrap and iterate over the optional array `elementImage`
        if let imageDataArray = orderForm.elementImage {
            for imageData in imageDataArray {
                if let image = UIImage(data: imageData) {
                    images.append(image)
                }
            }
        }

        // Default images
        let defaultImages: [UIImage] = [
            UIImage(systemName: "star.fill")!,
            UIImage(systemName: "heart.fill")!,
            UIImage(systemName: "sun.and.horizon.fill")!,
            UIImage(systemName: "sunglasses.fill")!,
            //UIImage(systemName: "paperplane.fill")!
        ]

        images.append(contentsOf: defaultImages)
        return images
    }

    
    
    @State var cakeImage: CGImage?
    
    //@Binding var selectedColor: Color
    @State private var showPicker = false
    @State private var updateTexture = false
    
    @State private var currentRotation: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    @State private var currentScale: SIMD3<Float> = SIMD3<Float>(1.0, 1.0, 1.0)
    
    let picker = PKToolPicker()
    @State var canvasView = PKCanvasView()
    
    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 0){
                Cake3DContainer(picker: picker, canvasView: canvasView, currentRotation: $currentRotation, currentScale: $currentScale, cakeImage: $cakeImage, isActive: $showPicker, selectedColor: Color(hex: orderForm.colorBackground ?? ""))
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
                    CakeCanvasContainer(canvasView: $canvasView, picker: picker, isActive: $showPicker, cakeImage: $cakeImage, orderFrom: orderForm)
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
        .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(hex: "#FA5738"))
                    }
                })
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
            
        }
    }
}


