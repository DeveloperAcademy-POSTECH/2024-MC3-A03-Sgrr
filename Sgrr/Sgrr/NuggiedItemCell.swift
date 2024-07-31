//
//  NuggiedItemCell.swift
//  Sgrr
//
//  Created by dora on 7/26/24.
//

import SwiftUI

struct NuggiedItemCell: View {
    let items = Array(0..<5)

    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(items, id: \.self) { item in
                        Rectangle()
                            .frame(width: 67, height: 67)
                            .id(item)
                    }
                }
                .onAppear {
                    scrollViewProxy.scrollTo(2, anchor: .center)
                }
            }
            .frame(height: 300)
        }
    }
}

#Preview {
    NuggiedItemCell()
}

