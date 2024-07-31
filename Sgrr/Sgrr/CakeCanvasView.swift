//
//  PKCanvasView.swift
//  Sgrr
//
//  Created by dora on 7/26/24.
//

import SwiftUI
import PencilKit
import PhotosUI

struct Canvas: View {
    let picker = PKToolPicker()
    @State private var canvasView = PKCanvasView()
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage? = nil

    var body: some View {
        VStack {
            Button(action: {
                showImagePicker = true
            }) {
                Text("Add Photo")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity)
            }
            .padding()
            
            DrawingViewContainer(canvasView: $canvasView, picker: picker)
                .onAppear {
                    picker.setVisible(true, forFirstResponder: canvasView)
                    picker.addObserver(canvasView)
                    canvasView.becomeFirstResponder()
                }
                .frame(maxHeight: .infinity)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, onImagePicked: { image in
                addImageToCanvas(image)
            })
        }
    }

    private func addImageToCanvas(_ image: UIImage) {
        print("addImageToCanvas")
        DispatchQueue.main.async {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: self.canvasView.bounds.width, height: self.canvasView.bounds.height)
            imageView.contentMode = .scaleAspectFit
            
            self.canvasView.addSubview(imageView)
            //self.canvasView.sendSubviewToBack(imageView)
        }
    }
}

struct DrawingViewContainer: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    let picker: PKToolPicker

    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 15)
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {}
}

struct ImagePicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        if let uiImage = image as? UIImage {
                            self.parent.onImagePicked(uiImage)
                        }
                    }
                }
            }
        }
    }

    @Binding var selectedImage: UIImage?
    var onImagePicked: (UIImage) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
}

#Preview {
    Canvas()
}




