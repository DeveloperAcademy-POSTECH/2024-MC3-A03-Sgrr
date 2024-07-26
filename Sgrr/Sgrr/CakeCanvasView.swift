//
//  PKCanvasView.swift
//  Sgrr
//
//  Created by dora on 7/26/24.
//

import SwiftUI
import PencilKit

struct Canvas: View {
    let picker = PKToolPicker()
    @State private var canvasView = PKCanvasView()
    
    var body: some View {
        DrawingViewContainer(canvasView: $canvasView, picker: picker)
            .onAppear {
                picker.setVisible(true, forFirstResponder: canvasView)
                picker.addObserver(canvasView)
                canvasView.becomeFirstResponder()
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

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
}

#Preview {
    Canvas()
}
