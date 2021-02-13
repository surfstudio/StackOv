//
//  QuestionView.swift
//  StackOv (HomeFlow module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Common
import Components
import Icons

struct QuestionView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Issue in React Native upload file using XMLHttpRequest. Error - Request has not been opened")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            HStack(spacing: 24) {
                Text("Asked 9 years, 6 months ago")
                Text("Active today")
                Text("Viewed 817k times")
            }
            .font(.caption)
            .padding(.bottom, 24)
            
            Divider()
                .padding(.bottom, 24)
            
            HStack(alignment: .top, spacing: .zero) {
                HStack {
                    RetingView()
                    Spacer()
                }.frame(maxWidth: 60)
                MarkdownPostView(text: .constant("How can I set a SwiftUI `Text` to display rendered HTML or Markdown?\r\n\r\nSomething like this:  \r\n    \r\n    Text(HtmlRenderedString(fromString: &quot;&lt;b&gt;Hi!&lt;/b&gt;&quot;))\r\nor for MD:  \r\n\r\n    Text(MarkdownRenderedString(fromString: &quot;**Bold**&quot;))\r\n\r\nPerhaps I need a different View?"))
            }
        }
    }
}

fileprivate struct RetingView: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Button(action: {}, icon: .handThumbsupFill)
                .frame(width: 20, height: 20)
            Text("363")
                .font(.subheadline)
            Button(action: {}, icon: .handThumbsdownFill)
                .frame(width: 20, height: 20)
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView()
    }
}
