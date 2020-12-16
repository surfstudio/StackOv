//
//  MessagesFlow.swift
//  This source file is part of the StackOv open source project
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
