//
//  PKCanvasView.swift
//  Sgrr
//
//  Created by dora on 7/26/24.
//

import SwiftUI
import PencilKit

enum Mode {
    case draw
    case addPhoto
}

struct Canvas: View {
    let items = Array(0..<5)
    let picker = PKToolPicker()
    
    @State private var canvasView = PKCanvasView()
    @State private var selectedMode: Mode = .draw
    
    var body: some View {
        VStack {
            /// picker 에서 버튼으로 바꾸기!
            Picker("Select Mode", selection: $selectedMode) {
                Text("Draw").tag(Mode.draw)
                Text("Add Photo").tag(Mode.addPhoto)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            DrawingViewContainer(canvasView: $canvasView, picker: picker)
                .onAppear {
                    if selectedMode == .addPhoto {
                        //picker.setVisible(true, forFirstResponder: canvasView)
                        picker.addObserver(canvasView)
                        canvasView.becomeFirstResponder()
                    }
                }
                .onDisappear {
                    picker.setVisible(false, forFirstResponder: canvasView)
                    picker.removeObserver(canvasView)
                }
            
            Spacer()
            
            if selectedMode == .draw {
                Text("Drawing Mode Active")
                    .onAppear {
                        //picker.setVisible(true, forFirstResponder: canvasView)
                        picker.setVisible(false, forFirstResponder: canvasView)
                        picker.addObserver(canvasView)
                        canvasView.becomeFirstResponder()
                    }
            } else if selectedMode == .addPhoto {
                HStack {
                    ForEach(items, id: \.self) { item in
                        Button(action: {
                            addImageToCanvas(UIImage(imageLiteralResourceName: "cakeElement_" + "\(item + 1)"))
                        }) {
                            ZStack {
                                Rectangle()
                                Image("cakeElement_" + "\(item + 1)")
                                    .resizable()
                                    .padding(5)
                            }
                        }
                        .frame(width: 67, height: 67)
                    }
                }
                .onAppear {
                    //picker.setVisible(true, forFirstResponder: canvasView)
                    picker.addObserver(canvasView)
                    canvasView.becomeFirstResponder()
                }
                .padding()
            }
        }
    }
    
    private func addImageToCanvas(_ image: UIImage) {
        print("addImageToCanvas")
        
        DispatchQueue.main.async {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            imageView.contentMode = .scaleAspectFit
            
            self.canvasView.addSubview(imageView)
            self.canvasView.sendSubviewToBack(imageView)
           
        }
    }
}

struct DrawingViewContainer: UIViewRepresentable {
    @Binding var canvasView: PKCanvasView
    let picker: PKToolPicker
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.backgroundColor = .clear
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 15)
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.backgroundColor = .clear
    }
    
    func exportUIView(){
        
    }
}

#Preview {
    Canvas()
}










