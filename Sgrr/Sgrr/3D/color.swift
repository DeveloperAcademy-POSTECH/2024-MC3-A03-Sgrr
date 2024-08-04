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
                    ColorPicker("Pick a color", selection: $selectedColor)
                        .padding()
                    
                    NavigationLink(destination: testView(selectedColor: $selectedColor)) {
                        Text("Go to Next View")
                    }
                    .padding()
                }
                .navigationTitle("Color Picker")
            }
        }
}

#Preview {
    color()
}
