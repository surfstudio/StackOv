//
//  UnitView.swift
//  StackOv (HTMLMarkdown module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public protocol UnitView: View {
    var unit: HTMLMarkdown.Unit { get }
}


public protocol StyleableUnitView: UnitView {
    
    associatedtype Style
    
    var style: Style { get }
    
}
