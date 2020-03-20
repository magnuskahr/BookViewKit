//
//  RotatingPage.swift
//  BookView
//
//  Created by Magnus Jensen on 19/02/2020.
//  Copyright © 2020 Magnus Jensen. All rights reserved.
//

import SwiftUI

enum PageSide {
    case left, right
}

struct RotatingPage<FrontContent: View, BackContent: View>: View {
    
    @State private var lastSide: PageSide = .right
    @State private var rotation: Double = 0
    
    let front: Page<FrontContent>
    let back: Page<BackContent>
    let didFlip: (PageSide) -> ()
    
    private var gesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
        .onChanged { value in
            var drag = value.translation.width
            if self.lastSide == .left {
                drag -= 180
            }
            self.rotation = min(0, max(-180, Double(drag)))
            if self.rotation >= -90 {
                self.didFlip(.right)
            } else {
                self.didFlip(.left)
            }
        }
        .onEnded { value in
            withAnimation(.easeOut) {
                if self.rotation >= -90 {
                    self.rotation = 0
                    if self.lastSide == .left {
                        self.lastSide = .right
                    }
                } else {
                    self.rotation = -180
                    if self.lastSide == .right {
                        self.lastSide = .left
                    }
                }
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            GeometryReader { reader in
                HStack {
                    Spacer()
                    DoublePage(front: self.front, back: self.back, rotation: self.rotation)
                    .frame(width: reader.size.width / 2)
                    .rotation3DEffect(.degrees(self.rotation), axis: (x: 0, y: 1, z: 0), anchor: .leading, anchorZ: 0, perspective: 0.5)
                }
            }.gesture(gesture)
        }
    }
}

struct RotatingPage_Previews: PreviewProvider {
    static var previews: some View {
        RotatingPage(front: Page(content: Color.red),
                     back: Page(content: Color.green)) { _ in }
    }
}
