//
//  ContentView.swift
//  BookView
//
//  Created by Magnus Jensen on 18/02/2020.
//  Copyright © 2020 Magnus Jensen. All rights reserved.
//

import SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

struct PageData<Content: Identifiable> {
    let content: Content
    let placement: Placement
}

enum Placement {
    case front
    case left
    case right
    case back
}

struct BookView<Content: Identifiable, PageContent: View>: View {
    
    private typealias DoublePageContent = (a: Content, b: Content)
    
    private let content: [DoublePageContent]
    private let builder: (PageData<Content>) -> PageContent
    
    @State private var highlight = 0
    
    init(content: [Content], @ViewBuilder pageBuilder: @escaping (PageData<Content>) -> PageContent) {
        self.builder = pageBuilder
        var pairs = [DoublePageContent]()
        for chunk in content.chunked(into: 2) {
            if chunk.count > 1 {
                pairs.append((a: chunk[0], b: chunk[1]))
            } else {
                pairs.append((a: chunk[0], b: chunk[0]))
            }
        }
        self.content = pairs
    }
    
    var body: some View {
        ZStack {
            ForEach((0..<content.count).reversed(), id: \.self) { index in
                RotatingPage(front: self.pageA(for: index), back: self.pageB(for: index)) { side in
                    self.highlight = side == .right ? index - 1 : index
                }.zIndex(self.zindex(for: index))
            }
        }
    }
    
    private func placement(for index: Int, side: Placement) -> Placement {
        if index == 0 && side == .left {
            return .front
        }
        if index == content.count - 1 && side == .right {
            return .back
        }
        return side
    }
    
    private func pageA(for index: Int) -> Page<PageContent> {
        let placement = self.placement(for: index, side: .left)
        let description = PageData(content: self.content[index].a, placement: placement)
        return Page(content: self.builder(description))
    }
    
    private func pageB(for index: Int) -> Page<PageContent> {
        let placement = self.placement(for: index, side: .right)
        let description = PageData(content: self.content[index].b, placement: placement)
        return Page(content: self.builder(description))
    }
    
    private func zindex(for index: Int) -> Double {
        if self.highlight == index {
            return 2
        }
        if self.highlight - 1 == index {
            return 1
        }
        return 0
    }
}
