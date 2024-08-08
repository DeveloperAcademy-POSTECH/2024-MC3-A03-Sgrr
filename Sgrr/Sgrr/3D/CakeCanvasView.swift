//
//  CakeCanvasView_test.swift
//  Sgrr
//
//  Created by dora on 7/30/24.
//

import SwiftUI
import PencilKit
import Vision
import CoreImage.CIFilterBuiltins

struct CakeCanvasContainer: UIViewRepresentable {
    
    /// PKCanvas관련
    @Binding var canvasView: PKCanvasView
    let picker: PKToolPicker
    @Binding var isActive: Bool
    
    /// Material 만들 이미지 관련
    @Binding var cakeImage: CGImage?
    
    /// 요소 이미지 불러오기 위한 주문서 모델
    
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
        
        //if isActive {
            context.coordinator.updateCakeImage(from: uiView)
        //}
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
            DispatchQueue.main.async {
                self.cakeImage = canvasView.asImage()
            }
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
    @State private var isLoading: Bool = false
    @State private var processedImage: UIImage?
        private let processingQueue = DispatchQueue(label: "ProcessingQueue")

    
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
        .frame(height: 50)
        
    }
    
    /// 사진 추가
    func addPhoto(_ image: UIImage) {
            createSticker(from: image) { processedImage in
                guard let processedImage = processedImage else { return }
                let image = DraggableImage(image: processedImage)
                image.frame = CGRect(x: 0, y: 0, width: processedImage.size.width/3, height: processedImage.size.height/3)
                image.contentMode = .scaleAspectFit

                let canvasCenter = CGPoint(x: canvasView.bounds.midX, y: canvasView.bounds.midY)
                image.center = canvasCenter

                self.canvasView.addSubview(image)
            }
        }
}

extension PhotoPickerCell {
    private func createSticker(from image: UIImage, completion: @escaping (UIImage?) -> Void) {
        guard let inputImage = CIImage(image: image) else {
            print("Failed to create CIImage")
            completion(nil)
            return
        }

        let fixedImage = removedOrientationImage(image)

        guard let inputImage = CIImage(image: fixedImage) else {
            print("Failed to create CIImage")
            completion(nil)
            return
        }

        isLoading = true
        processingQueue.async {
            guard let maskImage = subjectMaskImage(from: inputImage) else {
                print("Failed to create mask image")
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                completion(nil)
                return
            }
            let outputImage = apply(maskImage: maskImage, to: inputImage)
            let image = render(ciImage: outputImage)
            DispatchQueue.main.async {
                self.isLoading = false
                self.processedImage = image
                completion(image)
            }
        }
    }

    private func subjectMaskImage(from inputImage: CIImage) -> CIImage? {
        let handler = VNImageRequestHandler(ciImage: inputImage)
        let request = VNGenerateForegroundInstanceMaskRequest()
        do {
            try handler.perform([request])
        } catch {
            print(error)
            return nil
        }
        guard let result = request.results?.first else {
            print("No observations found")
            return nil
        }
        do {
            let maskPixelBuffer = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
            return CIImage(cvPixelBuffer: maskPixelBuffer)
        } catch {
            print(error)
            return nil
        }
    }

    private func apply(maskImage: CIImage, to inputImage: CIImage) -> CIImage {
        let filter = CIFilter.blendWithMask()
        filter.inputImage = inputImage
        filter.maskImage = maskImage
        filter.backgroundImage = CIImage.empty()
        return filter.outputImage!
    }

    private func render(ciImage: CIImage) -> UIImage {
        guard let cgImage = CIContext(options: nil).createCGImage(ciImage, from: ciImage.extent) else {
            fatalError("Failed to render CGImage")
        }
        return UIImage(cgImage: cgImage)
    }

    private func removedOrientationImage(_ image: UIImage) -> UIImage {
        guard image.imageOrientation != .up else { return image }
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: image.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return normalizedImage ?? image
    }
}



