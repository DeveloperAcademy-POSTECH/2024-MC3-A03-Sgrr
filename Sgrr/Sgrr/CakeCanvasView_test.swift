//
//  CakeCanvasView_test.swift
//  Sgrr
//
//  Created by dora on 7/30/24.
//

// CakeCanvasView_test.swift
import SwiftUI
import PencilKit

struct CakeCanvasView_test: View {
    @Binding var cakeImage: CGImage?

    let palette = PKToolPicker()
    @State private var canvasView = PKCanvasView()
    @State var showPhotoPalette: Bool = true

    var body: some View {
        VStack {
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.backward")
                }
                
                Spacer()
                
                Button(action: {
                    if let image = exportImage(canvas: canvasView) {
                        cakeImage = image
                    }
                }) {
                    Image(systemName: "checkmark.seal.fill")
                }
                
                Button(action: {
                    palette.setVisible(true, forFirstResponder: canvasView)
                    showPhotoPalette = false
                }) {
                    Image(systemName:"applepencil.tip")
                }
                
                Button(action: {
                    palette.setVisible(false, forFirstResponder: canvasView)
                    showPhotoPalette = true
                }) {
                    Image(systemName:"photo")
                }
            }
            .padding()
            .background(Color(.systemBackground))
            
            ZStack {
                CanvasViewContainer(canvasView: $canvasView, palette: palette)
                    .onAppear {
                        palette.setVisible(false, forFirstResponder: canvasView)
                        palette.addObserver(canvasView)
                        canvasView.becomeFirstResponder()
                    }
                
                if showPhotoPalette {
                    VStack {
                        Spacer()
                        HStack {
                            ForEach(0..<5) { index in
                                Button(action: {
                                    addPhoto(UIImage(named: "cakeElement_\(index + 1)")!)
                                }) {
                                    ZStack {
                                        Rectangle()
                                        Image("cakeElement_\(index + 1)")
                                            .resizable()
                                            .padding(5)
                                    }
                                    .frame(width: 67, height: 67)
                                }
                            }
                        }
                    }
                    .background(Color(.clear))
                    .animation(.easeInOut)
                    .transition(.move(edge: .bottom))
                }
            }
        }
    }
    
    func addPhoto(_ image: UIImage) {
        DispatchQueue.main.async {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            imageView.contentMode = .scaleAspectFit
            self.canvasView.addSubview(imageView)
        }
    }
    
    func exportImage(canvas: UIView) -> CGImage? {
        guard let exportedImage = canvas.asImage() else { return nil }
        return exportedImage
    }
    
    struct CanvasViewContainer: UIViewRepresentable {
        @Binding var canvasView: PKCanvasView
        let palette: PKToolPicker
        
        func makeUIView(context: Context) -> PKCanvasView {
            canvasView.backgroundColor = .clear
            canvasView.tool = PKInkingTool(.pen, color: .blue, width: 15)
            return canvasView
        }
        
        func updateUIView(_ uiView: PKCanvasView, context: Context) {
            uiView.backgroundColor = .clear
        }
    }
}

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

 
