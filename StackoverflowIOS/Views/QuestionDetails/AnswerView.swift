//
//  AnswerView.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 24/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

struct AnswerView: View {
    let model: AnswerModel
    
    var body: some View {
        VStack(spacing: 6) {
            // - TODO: need add an information about owner
            HStack(alignment: .top, spacing: 6) {
                Color.answer(model.isAccepted).frame(width: 4)
                MarkdownView(text: .constant(model.body.htmlUnescape()))
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.leading, 6)
        .padding(.trailing, 16)
    }
}

// MARK: - Extensions

fileprivate extension Color {
    static let title = Color("questionTitle")
    static func answer(_ isAccepted: Bool) -> Color {
        isAccepted ? Color("acceptedAnswer") : Color.gray
    }
    #if DEBUG
    static let background = Color("mainBackground")
    #endif
}
