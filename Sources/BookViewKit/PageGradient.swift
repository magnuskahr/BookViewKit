//
//  PageGradientBackground.swift
//  BookView
//
//  Created by Magnus Jensen on 20/02/2020.
//  Copyright © 2020 Magnus Jensen. All rights reserved.
//

import SwiftUI

public struct PageGradient: View {
    
    public let placement: Placement
    
    public var body: some View {
        LinearGradient (
            gradient: Gradient(colors: [.clear, .white]),
            startPoint: placement == .left ? .trailing : .leading,
            endPoint: placement == .right ? .trailing : .leading
        ).colorInvert().opacity(0.15)
        .opacity([Placement.front, .back].contains(placement) ? 0 : 1)
    }
}

struct PageGradientBackground_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue
            PageGradient(placement: .left)
        }
    }
}
