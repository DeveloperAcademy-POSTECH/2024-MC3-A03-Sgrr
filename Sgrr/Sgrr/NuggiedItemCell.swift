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
                            .frame(width: 100, height: 100)
                            .id(item) // 각 Rectangle에 고유한 ID를 부여합니다.
                    }
                }
                .onAppear {
                    // 초기 스크롤 위치를 설정합니다.
                    // 여기 이해해야함
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

