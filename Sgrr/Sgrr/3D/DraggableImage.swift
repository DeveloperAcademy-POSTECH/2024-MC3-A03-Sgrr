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

    override init(image: UIImage?) {
        super.init(image: image)
        self.isUserInteractionEnabled = true
        addPanGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("NSCoder 불러오기 실패!")
    }
    /// PanGesture가 Drag..
    private func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.addGestureRecognizer(panGesture)
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
}
