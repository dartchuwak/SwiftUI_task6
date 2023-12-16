//
//  ContentView.swift
//  SwiftUI_task6
//
//  Created by Evgenii Mikhailov on 16.12.2023.
//


import SwiftUI

struct VStackLayout: Layout {
    let itemCount: Int
    @Binding var isAnim: Bool
    let spacing: CGFloat

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {

        return proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {

        let squareSize = bounds.height / CGFloat(itemCount)
        let offsetXStep = (bounds.width - squareSize) / CGFloat(itemCount - 1)
        let totalSpacing = spacing * CGFloat(itemCount - 1)
        let availableWidth = bounds.width - totalSpacing


        let itemWidth = availableWidth / CGFloat(itemCount)
            for index in subviews.indices {
                if isAnim {

                    let offsetX = offsetXStep * CGFloat(index)
                    let offsetY = bounds.height - squareSize - (squareSize * CGFloat(index))
                    let frame = CGRect(x: offsetX, y: bounds.height - offsetY, width: squareSize, height: squareSize)
                    subviews[index].place(at: frame.origin, anchor: .leading, proposal: ProposedViewSize(frame.size))
                } else {

                    let offsetX = (itemWidth + spacing) * CGFloat(index)
                    let frame = CGRect(x: offsetX, y: bounds.height / 2, width: itemWidth, height: itemWidth)
                    subviews[index].place(at: frame.origin, anchor: .topLeading, proposal: ProposedViewSize(frame.size))
            }
        }
    }
}

struct ContentView: View {
    @State var  isAnim = false
    var body: some View {
    VStack {
        VStackLayout(itemCount: 7, isAnim: $isAnim, spacing: 10) {
            ForEach(0..<7, id: \.self) { _ in
                Rectangle()
                    .fill(Color.blue)
            }
        }
    }
        .onTapGesture {
            withAnimation {
                isAnim.toggle()
            }
        }
    }
}

#Preview {
    ContentView()
}
