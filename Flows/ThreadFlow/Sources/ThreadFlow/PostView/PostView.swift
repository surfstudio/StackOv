//
//  PostView.swift
//  StackOv (ThreadFlow module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Components
import Common

struct PostView: View {
    
    // MARK: - Properties

    let model: PostModel

    // MARK: - Views

    var body: some View {
        MarkdownPostView(text: .constant(model.body))
    }
}

// MARK: - Previews

struct PostView_Previews: PreviewProvider {
    
    static var previews: some View {
        PostView(model: PostModel.mock())
    }
}
