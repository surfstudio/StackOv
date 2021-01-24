//
//  PageDevMock.swift
//  StackOv (Components module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
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
