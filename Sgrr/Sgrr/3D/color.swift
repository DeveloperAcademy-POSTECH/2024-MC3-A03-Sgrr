//
//  color.swift
//  Sgrr
//
//  Created by dora on 8/4/24.
//

import SwiftUI

struct color: View {
    @State private var selectedColor: Color = .white
        
        var body: some View {
            NavigationView {
                VStack {
                    ColorPicker("배경색", selection: $selectedColor)
                        .padding()
                    
                    NavigationLink(destination: testView(selectedColor: $selectedColor)) {
                        Text("3D")
                    }
                    .padding()
                }
                .navigationTitle("케익색 고르기")
            }
        }
}

#Preview {
    color()
}
