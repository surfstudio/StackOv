//
//  UnitData.swift
//  StackOv (Markdown module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation

public extension Markdown {
    
    enum UnitData {
        case code(codeType: String?, code: String)
        case text(NSAttributedString.HTMLResult)
    }
}
