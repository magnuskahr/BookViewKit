//
//  Page.swift
//  BookView
//
//  Created by Magnus Jensen on 19/02/2020.
//  Copyright © 2020 Magnus Jensen. All rights reserved.
//

import SwiftUI

struct Page<Content: View>: View {
    let content: Content
    var body: some View {
        ZStack {
            Color.white
            content
        }.cornerRadius(8)
    }
}

struct Page_Previews: PreviewProvider {
    static var previews: some View {
        Page(content: Color.red)
    }
}
