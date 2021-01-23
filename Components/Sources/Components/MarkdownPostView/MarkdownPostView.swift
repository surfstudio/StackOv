//
//  MarkdownPostView.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import HTMLEntities
import Markdown

public struct MarkdownPostView: View {
    
    @Binding var text: String
    
    init(text: Binding<String>) {
        self._text = text
    }
    
    public var body: some View {
        if let unit = Markdown.Unit(text), unit.type == .document {
            Markdown.DocumentView(unit: unit)
        } else {
            EmptyView()
        }
    }
}

// MARK: - Previews

struct MarkdownPostView_Previews: PreviewProvider {
    static let text = "How can I set a SwiftUI `Text` to display rendered HTML or Markdown?\r\n\r\nSomething like this:  \r\n    \r\n    Text(HtmlRenderedString(fromString: &quot;&lt;b&gt;Hi!&lt;/b&gt;&quot;))\r\nor for MD:  \r\n\r\n    Text(MarkdownRenderedString(fromString: &quot;**Bold**&quot;))\r\n\r\nPerhaps I need a different View?"
    static var previews: some View {
        Group {
            MarkdownPostView(text: .constant(text.htmlUnescape()))
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.mainBackground)
                .environment(\.colorScheme, .light)
            
            MarkdownPostView(text: .constant(text.htmlUnescape()))
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.mainBackground)
                .environment(\.colorScheme, .dark)
        }
    }
}

// MARK: - Extensions

fileprivate extension Color {
    
    static let mainBackground = Color("mainBackground")
}
