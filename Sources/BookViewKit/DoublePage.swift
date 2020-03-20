//
//  DoublePage.swift
//  BookView
//
//  Created by Magnus Jensen on 19/02/2020.
//  Copyright © 2020 Magnus Jensen. All rights reserved.
//

import SwiftUI

struct DoublePage<FrontContent: View, BackContent: View>: View {
    
    let front: Page<FrontContent>
    let back: Page<BackContent>
    let rotation: Double
    
    private var showFront: Bool {
        abs(rotation) < 90
    }
    
    var body: some View {
        ZStack {
            back.rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
            front.opacity(showFront ? 1 : 0)
        }.animation(nil)
    }
}

struct DoublePage_Previews: PreviewProvider {
    static var previews: some View {
        DoublePage(
            front: Page(content: Color.red),
            back: Page(content: Color.green),
            rotation: 15)
    }
}
