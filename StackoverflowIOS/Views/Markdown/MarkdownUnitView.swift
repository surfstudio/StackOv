//
//  MarkdownUnitView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 17/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

protocol MarkdownUnitView: View {
    var unit: Markdown.Unit { get }
}
