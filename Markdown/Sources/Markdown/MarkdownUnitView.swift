//
//  MarkdownUnitView.swift
//  StackOv (Markdown module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public protocol MarkdownUnitView: View {
    
    var unit: Markdown.Unit { get }
}
