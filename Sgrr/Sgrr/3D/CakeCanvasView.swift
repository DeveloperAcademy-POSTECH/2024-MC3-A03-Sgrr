//
//  CakeCanvasView_test.swift
//  Sgrr
//
//  Created by dora on 7/30/24.
//

import SwiftUI
import PencilKit

let sampleImages: [UIImage] = [
    UIImage(systemName: "star.fill")!,
    UIImage(systemName: "heart.fill")!,
    UIImage(systemName: "sun.and.horizon.fill")!,
    UIImage(systemName: "sunglasses.fill")!,
    UIImage(systemName: "paperplane.fill")!
]


struct CakeCanvasContainer: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    let picker: PKToolPicker
    
    @Binding var isActive: Bool
    @Binding var cakeImage: CGImage?
    
    func makeUIView(context: Context) -> PKCanvasView {
        self.canvasView.tool = PKInkingTool(.pen, color: .black, width: 15)
        self.canvasView.becomeFirstResponder()
        canvasView.backgroundColor = .clear
        
        canvasView.delegate = context.coordinator
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        picker.setVisible(isActive, forFirstResponder: uiView)
        //uiView.backgroundColor = .clear
        picker.addObserver(canvasView)
        
        if isActive {
            context.coordinator.updateCakeImage(from: uiView)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(cakeImage: $cakeImage)
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        @Binding var cakeImage: CGImage?
        
        init(cakeImage: Binding<CGImage?>) {
            self._cakeImage = cakeImage
        }
        
        /// 😨여기 호출 어떻게 이루어지는지 모르겠음
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            // 캔버스가 업데이트 될 때마다 호출됨
            DispatchQueue.main.async {
                self.updateCakeImage(from: canvasView)
            }
        }
        
        func updateCakeImage(from canvasView: PKCanvasView) {
            self.cakeImage = canvasView.asImage()
        }
    }
}


// UIImage -> CGImage 변환
extension UIView {
    func asImage() -> CGImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        let uiImage = renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
        
        guard let ciImage = CIImage(image: uiImage) else { return nil }
        let ciContext = CIContext(options: nil)
        return ciContext.createCGImage(ciImage, from: ciImage.extent)
    }
}

/// 사진 팔레트
struct PhotoPickerCell: View {
    
    let images: [UIImage]
    var canvasView: PKCanvasView
    
    var body: some View {
        HStack {
            ForEach(0..<images.count, id: \.self) { index in
                Button(action: {
                    addPhoto(images[index])
                }){
                    ZStack{
                        Rectangle()
                            .foregroundColor(.white)
                            .shadow(radius: 1.5)
                        
                        Image(uiImage: images[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(5)
                            .frame(width: 67, height: 67)
                    }
                }
            }
        }
        .frame(height: 45)
        
    }
    
    /// 사진 추가
    func addPhoto(_ image: UIImage) {
        let imageView = DraggableImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 67, height: 67)
        imageView.contentMode = .scaleAspectFit
        
        let canvasCenter = CGPoint(x: canvasView.bounds.midX, y: canvasView.bounds.midY)
        imageView.center = canvasCenter
        
        self.canvasView.addSubview(imageView)
    }
}



