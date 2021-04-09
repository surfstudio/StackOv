//
//  SnippetContainer.swift
//  StackOv (Markdown module)
//
//  Created by Илья Князьков
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

final class SnippetContainer {

    var snippetBlock: Bool
    var snippetCodeType: String?
    var snippets: [Markdown.Unit]

    init(snippetBlock: Bool = false, snippetCodeType: String? = nil, snippets: [Markdown.Unit] = []) {
        self.snippetBlock = snippetBlock
        self.snippetCodeType = snippetCodeType
        self.snippets = snippets
    }
}
