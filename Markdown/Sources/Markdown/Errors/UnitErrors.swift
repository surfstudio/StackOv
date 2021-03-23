//
//  UnitErrors.swift
//  StackOv (Markdown module)
//
//  Created by Илья Князьков
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public enum UnitErrors: String {

    case unrecognizedUnit = "Unrecognized unit!"
    case couldtCreateUnit = "Could\'t create unit!"
    case unexpectedError = "Unexpected error!"
    case beginSnippet = "Begin of snippet"
    case snippetType = "Snippet type"
    case snippetEnd = "Snippet end"
    case snippetIsEmpty = "Snippet is empty"
    case isSnippet = "Is snippet"
    case isSnippetBody = "Is snipped body"
}

extension UnitErrors: LocalizedError {

    var localizedDescription: String {
        rawValue
    }
}
