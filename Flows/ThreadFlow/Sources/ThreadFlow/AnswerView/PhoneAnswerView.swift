//
//  [NAME].swift
//  StackOv ([NAME] module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Common
import Components
import Palette

struct PhoneAnswerView: View {
    
    // MARK: - Properties
    
    let model: AnswerModel
    
    // MARK: - Views
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            MarkdownPostView(text: .constant(model.body ?? ""))
            buttons
            PersonInfoView(model: UserModel.mock(), indent: 12, isFullScreen: true)
            
            HStack {
                RetingView(viewed: model.formattedVotesNumber, isVertical: false)
                Spacer()
                Button("Add comment") {
                    // TODO: Add functionality in the future
                }
                .font(.subheadline)
                .foregroundColor(Palette.main)
            }
        }
    }
    
    var buttons: some View {
        HStack(alignment: .center, spacing: 24) {
            Button("Share") {
                // TODO: Add functionality in the future
            }
            Button("Edit") {
                // TODO: Add functionality in the future
            }
            Button("Follow") {
                // TODO: Add functionality in the future
            }
        }
        .font(.subheadline)
        .foregroundColor(Palette.main)
    }
    
}

// MARK: - Previews

struct PhoneAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneAnswerView(model: AnswerModel.mock())
    }
}
