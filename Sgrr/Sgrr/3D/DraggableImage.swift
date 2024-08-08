//
//  Draggable.swift
//  Sgrr
//
//  Created by dora on 8/4/24.
//

import SwiftUI
import UIKit
import PencilKit

class DraggableImage: UIImageView {
    
    var originalPosition: CGPoint?
    var currentScale: CGFloat = 1.0

    override init(image: UIImage?) {
        super.init(image: image)
        self.isUserInteractionEnabled = true
        addPanGesture()
        addPinchGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("NSCoder 불러오기 실패!")
    }
    
    private func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.addGestureRecognizer(panGesture)
    }
    
    private func addPinchGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        self.addGestureRecognizer(pinchGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            originalPosition = self.center
        case .changed:
            let translation = gesture.translation(in: self.superview)
            self.center = CGPoint(x: originalPosition!.x + translation.x, y: originalPosition!.y + translation.y)
        default:
            break
        }
    }
    
    @objc private func handlePinchGesture(_ gesture: UIPinchGestureRecognizer) {
        switch gesture.state {
        case .began, .changed:
            self.transform = self.transform.scaledBy(x: gesture.scale, y: gesture.scale)
            gesture.scale = 1.0
        default:
            break
        }
    }
}

