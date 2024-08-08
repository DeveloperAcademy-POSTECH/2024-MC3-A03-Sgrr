//
//  testView.swift
//  Sgrr
//
//  Created by dora on 7/31/24.
//

import SwiftUI
import PencilKit
import CoreData

var defaultImages: [UIImage] = [
    UIImage(systemName: "sun.min.fill")!,
    UIImage(systemName: "moon.stars.fill")!,
    UIImage(systemName: "music.note")!,
    UIImage(systemName: "star")!,
    UIImage(systemName: "smoke")!
]

struct CakeView: View {
    @EnvironmentObject var router: Router
    @Environment(\.presentationMode) var presentationMode

    let coredataManager = CoredataManager.shared
    @State var cake: [Cake] = []

    @State var cakeImage: CGImage?
    @State private var showPicker = false
    @State private var currentRotation: SIMD3<Float> = SIMD3<Float>(0.0, 0.0, 0.0)
    @State private var currentScale: SIMD3<Float> = SIMD3<Float>(1.0, 1.0, 1.0)

    let picker = PKToolPicker()
    @State var canvasView = PKCanvasView()
    @State var finalImages: [UIImage] = []
    


    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 0) {
                if let lastCake = cake.last {
                    Cake3DContainer(picker: picker, canvasView: canvasView, currentRotation: $currentRotation, currentScale: $currentScale, cakeImage: $cakeImage, isActive: $showPicker, selectedColor: Color(hex: lastCake.colorBG))
                        .edgesIgnoringSafeArea(.all)
                        .gesture(TapGesture().onEnded {
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
                        .frame(height: geometry.size.height / 2.5)
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(hex: "#CCC7B4"))
                            .ignoresSafeArea()
                        
                        VStack {
                            CanvasBackgroundView()
                            Spacer().frame(height: 130)
                        }
                        CakeCanvasContainer(canvasView: $canvasView, picker: picker, isActive: $showPicker, cakeImage: $cakeImage)
                        
                        if !showPicker {
                            VStack {
                                Spacer()
                                if finalImages.isEmpty {
                                    PhotoPickerCell(images: defaultImages, canvasView: canvasView)
                                        .frame(height: 130)
                                        .background(Color(hex:"#F4F4F4"))
                                }else{
                                    PhotoPickerCell(images: finalImages, canvasView: canvasView)
                                        .frame(height: 130)
                                        .background(Color(hex:"#F4F4F4"))
                                }
                                
                            }
                            .animation(.easeInOut)
                            .transition(.move(edge: .bottom))
                        }
                    }
                    .frame(height: geometry.size.height / 1.5)
                }
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
                    Button(action: {
                        showPicker = false
                    }) {
                        Image(systemName: "photo.on.rectangle")
                            .foregroundColor(Color(hex: "#FA5738"))
                    }
                    Button(action: {
                        showPicker = true
                    }) {
                        Image(systemName: "pencil.tip.crop.circle")
                            .foregroundColor(Color(hex: "#FA5738"))
                    }
                }
            }
        }
        .onAppear {
            fetchData()
            fetchImages()
        }
    }

    private func fetchData() {
        cake = coredataManager.getAllOrders()
    }

    private func fetchImages() {
        let orders = coredataManager.getAllOrders()
        var finalImages: [UIImage] = []

        if let order = orders.last {
            for element in order.cakeElement {
                if let elementImage = element.elementImage, let image = UIImage(data: elementImage) {
                    finalImages.append(image)
                }
            }
        }

        self.finalImages = finalImages
    }
}



