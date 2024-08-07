//
//  canvasBG.swift
//  Sgrr
//
//  Created by dora on 8/4/24.
//


import SwiftUI

/// 캔버스 가이드 배경 with GPT
struct CanvasBackgroundView: View {
    var body: some View {
        
        Canvas { context, size in
            
            let lineWidth: CGFloat = 0.5
            let dashPattern: [CGFloat] = [5, 5]
            let thirds: [CGFloat] = [1/3, 2/3]
            
            for division in thirds {
                // Horizontal lines
                let startY = size.height * division
                context.stroke(Path { path in
                    path.move(to: CGPoint(x: 0, y: startY))
                    path.addLine(to: CGPoint(x: size.width, y: startY))
                }, with: .color(Color(hex: "#545456")), lineWidth: lineWidth)
                
                // Vertical lines
                let startX = size.width * division
                context.stroke(Path { path in
                    path.move(to: CGPoint(x: startX, y: 0))
                    path.addLine(to: CGPoint(x: startX, y: size.height))
                }, with: .color(Color(hex: "#545456")), lineWidth: lineWidth)
            }
            
            // Draw dashed circle at the center
            let circleRadius = min(size.width, size.height) / 3
            let circleRect = CGRect(
                x: (size.width - circleRadius * 2) / 2,
                y: (size.height - circleRadius * 2) / 2,
                width: circleRadius * 2,
                height: circleRadius * 2
            )
            
            context.stroke(Path { path in
                path.addEllipse(in: circleRect)
            }, with: .color(Color(hex: "FA8C76")), style: StrokeStyle(lineWidth: 2, dash: dashPattern))
        }
        
    }
}

#Preview {
    CanvasBackgroundView()
}
