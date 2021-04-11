//
//  PostModel.swift
//  StackOv (Common module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public struct PostModel {
    
    // MARK: - Properties
    
    public let body: String

}

// MARK: - Extensions

public extension PostModel {
    
    static func mock() -> PostModel {
        PostModel(body: "How can I set a SwiftUI `Text` to display rendered HTML or Markdown?\r\n\r\nSomething like this:  \r\n    \r\n    Text(HtmlRenderedString(fromString: &quot;&lt;b&gt;Hi!&lt;/b&gt;&quot;))\r\nor for MD:  \r\n\r\n    Text(MarkdownRenderedString(fromString: &quot;**Bold**&quot;))\r\n\r\nPerhaps I need a different View?")
    }
}

// MARK: - Converter

public extension PostModel {
    
    static func from(model: QuestionModel) -> PostModel {
        PostModel(body: model.body)
    }
    
    static func from(model: AnswerModel) -> PostModel {
        PostModel(body: model.body ?? "")
    }

}
