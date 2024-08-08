//
//  Nuggie.swift
//  Sgrr
//
//  Created by dora on 8/8/24.
//

import SwiftUI
import Vision
import CoreImage.CIFilterBuiltins

struct Nuggie: View {

    @State private var image: UIImage
    @State private var sticker: UIImage?
    @State private var isLoading: Bool = false

    private var processingQueue = DispatchQueue(label: "ProcessingQueue")

    var body: some View {
        VStack {
            StickerView(image: $image, sticker: $sticker)
            Button("Create a sticker") {
                createSticker()
            }
        }
        .padding()
    }

    // MARK: - Private
//스티커 만드는 기능
    private func createSticker() {
        guard let inputImage = CIImage(image: image) else {
            print("Failed to create CIImage")
            return
        }
            let fixedImage = removedOrientationImage(image)
                
                guard let inputImage = CIImage(image: fixedImage) else {
                    print("Failed to create CIImage")
                    return
                }
        
        
        isLoading = true
        processingQueue.async {
            guard let maskImage = subjectMaskImage(from: inputImage) else {
                print("Failed to create mask image")
                DispatchQueue.main.async {
                    isLoading = false
                }
                return
            }
            let outputImage = apply(maskImage: maskImage, to: inputImage)
            let image = render(ciImage: outputImage)
            DispatchQueue.main.async {
                isLoading = false
                sticker = image
            }
        }
    }
// 마스킹하는 기능
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
    
    
}
    func removedOrientationImage(_ image: UIImage) -> UIImage {
        guard image.imageOrientation != .up else { return image }
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: image.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return normalizedImage ?? image
    }

struct StickerView: View {

    @Binding var image: UIImage
    @Binding var sticker: UIImage?
    @State private var spoilerViewOpacity: Double = 0
    @State private var stickerScale: Double = 1

    private let animation: Animation = .easeOut(duration: 1)

    var body: some View {
        ZStack {
            originalImage
            stickerImage
        }
    }

    // MARK: - Private

    @ViewBuilder
    private var originalImage: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
        // sticker가 있으면 opacity가 0이 됨
        // 스티커가 없으면 1 없으면 0
            .opacity(sticker == nil ? 1 : 0)
//            .animation(animation, value: sticker)
//            .overlay {
//                SpoilerView(isOn: true)
//                    .opacity(spoilerViewOpacity)
//            }
    }

    @ViewBuilder
    private var stickerImage: some View {
        if let sticker {
            Image(uiImage: sticker)
                .resizable()
                .scaledToFit()
                .scaleEffect(stickerScale)
                .onAppear {
                    withAnimation(animation) {
                        spoilerViewOpacity = 1
                        stickerScale = 1.1
                    } completion: {
                        withAnimation(.linear) {
                            spoilerViewOpacity = 0
                        }
                        withAnimation(animation) {
                            stickerScale = 1
                        }
                    }
                }
        }
    }
}
