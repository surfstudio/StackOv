//
//  PageDevMock.swift
//  This source file is part of the StackOv open source project
//

import SwiftUI

public struct PageDevMock: View {
    
    public init() {}
    
    public var body: some View {
        #if DEBUG
        VStack {
            Text("🛠")
                .font(.system(size: 150))
            Text("This page is not developed yet")
                .font(.largeTitle)
        }
        #else
        fatalError("PageDevMock must not be in a release version of the app")
        #endif
    }
}
