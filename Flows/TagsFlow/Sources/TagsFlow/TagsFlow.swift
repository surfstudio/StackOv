//
//  TagsFlow.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI
import Palette
import Components

public struct TagsFlow: View {
    
    public init() {}
    
    public var body: some View {
        PageDevMock()
            .foregroundColor(Color.foreground)
    }
}

// MARK: - Previews

struct TagsFlow_Previews: PreviewProvider {
    static var previews: some View {
        TagsFlow()
    }
}

// MARK: - Colors

fileprivate extension Color {
    static let foreground = Palette.dullGray
    static let background = Palette.bluishblack
}