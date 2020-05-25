//
//  MarkdownView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 16/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI
#if DEBUG
import HTMLEntities
#endif

struct MarkdownView: View {
    @Binding var text: String
    
    var body: some View {
        guard let unit = Markdown.Unit(text), unit.type == .document else {
            return AnyView(EmptyView())
        }
        return AnyView(Markdown.DocumentView(unit: unit))
    }
}

// MARK: - Previews

#if DEBUG
struct MarkdownView_Previews: PreviewProvider {
    static let text = "How can I set a SwiftUI `Text` to display rendered HTML or Markdown?\r\n\r\nSomething like this:  \r\n    \r\n    Text(HtmlRenderedString(fromString: &quot;&lt;b&gt;Hi!&lt;/b&gt;&quot;))\r\nor for MD:  \r\n\r\n    Text(MarkdownRenderedString(fromString: &quot;**Bold**&quot;))\r\n\r\nPerhaps I need a different View?"
    static var previews: some View {
        Group {
            MarkdownView(text: .constant(text.htmlUnescape()))
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.mainBackground)
                .environment(\.colorScheme, .light)
            
            MarkdownView(text: .constant(text.htmlUnescape()))
                .padding()
                .previewLayout(.sizeThatFits)
                .background(Color.mainBackground)
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif

// MARK: - Extensions

fileprivate extension Color {
    #if DEBUG
    static let mainBackground = Color("mainBackground")
    #endif
}
