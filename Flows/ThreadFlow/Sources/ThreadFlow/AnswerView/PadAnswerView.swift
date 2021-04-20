//
//  [NAME].swift
//  StackOv ([NAME] module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Components
import Common
import Palette

struct PadAnswerView: View {
    
    // MARK: - Properties
    
    let model: AnswerModel
    
    // MARK: - Views
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            RetingView(viewed: model.formattedVotesNumber, isVertical: true)
            content
        }
    }
    
    var content: some View {
        VStack(spacing: 24) {
            MarkdownPostView(text: .constant(model.body ?? ""))
            buttons
        }
    }
    
    var buttons: some View {
        HStack(spacing: 24) {
            Button("Share") {
                // TODO: Add functionality in the future
            }
            .font(.subheadline)
            .foregroundColor(Palette.main)
            .padding(.trailing, 4)
            Button("Edit") {
                // TODO: Add functionality in the future
            }
            .padding(.trailing, 4)
            .font(.subheadline)
            .foregroundColor(Palette.main)
            Button("Follow") {
                // TODO: Add functionality in the future
            }
            .font(.subheadline)
            .foregroundColor(Palette.main)
            Button("Add comment") {
                // TODO: Add functionality in the future
            }
            .font(.subheadline)
            .foregroundColor(Palette.main)
            
            Spacer()
            
            if model.lastEditDate != nil {
                Text("edited \(model.formattedLastEditDate)")
                    .font(.subheadline)
                    .foregroundColor(Palette.main)
            }
            PersonInfoView(model: UserModel.mock(), indent: 8, isFullScreen: false)
        }
    }
    
}

struct PadAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        PadAnswerView(model: AnswerModel.mock())
    }
}
