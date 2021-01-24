//
//  MessagesFlow.swift
//  StackOv (MessagesFlow module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Components

public struct MessagesFlow: View {
    
    public init() {}
    
    public var body: some View {
        PageDevMock()
            .foregroundColor(Color.foreground)
    }
}

// MARK: - Previews

struct MessagesFlow_Previews: PreviewProvider {
    static var previews: some View {
        MessagesFlow()
    }
}

// MARK: - Colors

fileprivate extension Color {
    static let foreground = Palette.dullGray
    static let background = Palette.bluishblack
}
