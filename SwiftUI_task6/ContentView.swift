//
//  ContentView.swift
//  SwiftUI_task6
//
//  Created by Evgenii Mikhailov on 16.12.2023.
//


import SwiftUI

struct MyLayout: Layout {

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {

        return proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let itemCount = subviews.count
        let squareSize = bounds.height / CGFloat(itemCount)
        let offsetXStep = (bounds.width - squareSize) / CGFloat(itemCount - 1)
            for index in subviews.indices {
                    let offsetX = offsetXStep * CGFloat(index)
                    let offsetY = squareSize * CGFloat(index)
                let frame = CGRect(x: offsetX + bounds.minX, y: bounds.maxY - squareSize - offsetY, width: squareSize, height: squareSize)
                    subviews[index].place(at: frame.origin,proposal: ProposedViewSize(frame.size))
        }
    }
}

struct ContentView: View {
    @State var  isAnim = false
    var body: some View {
        let layout = isAnim ? AnyLayout(MyLayout()) : AnyLayout(HStackLayout())
        layout {
            ForEach(0..<7, id: \.self) { _ in
                Rectangle()
                    .fill(Color.blue)
                    .cornerRadius(15)
                    .aspectRatio(1,contentMode: .fit)
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
