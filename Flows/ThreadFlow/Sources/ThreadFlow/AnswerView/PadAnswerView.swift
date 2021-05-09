//
//  PadAnswerView.swift
//  StackOv (ThreadFlow module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Components
import Common
import Palette
import AppScript

struct PadAnswerView: View {
    
    // MARK: - Properties
    
    let model: AnswerModel
    @EnvironmentObject var store: ThreadStore
    
    // MARK: - Views
    
    var body: some View {
        HStack(alignment: .top, spacing: .zero) {
            HStack(alignment: .center, spacing: .zero) {
                RetingView(viewed: model.formattedVotesNumber, isVertical: true)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .padding(.trailing, 34)
            .frame(width: 60, alignment: .leading)
            
            content
        }
    }
    
    var content: some View {
        VStack(spacing: 24) {
            MarkdownPostView(store.unit(of: model), style: .post)
                .fixedSize(horizontal: false, vertical: true)
            buttons
        }
    }
    
    var buttons: some View {
        HStack(spacing: 24) {
            Group {
                Button("Share") {
                    // TODO: Add functionality in the future
                }
                Button("Edit") {
                    // TODO: Add functionality in the future
                }
                Button("Follow") {
                    // TODO: Add functionality in the future
                }
                Button("Add comment") {
                    // TODO: Add functionality in the future
                }
            }
            .font(.subheadline)
            .foregroundColor(Palette.main)
            .lineLimit(1)

            Spacer()
            
            if model.lastEditDate != nil {
                Text("edited \(model.formattedLastEditDate)")
                    .font(.subheadline)
                    .foregroundColor(Palette.main)
            }
            PersonInfoView(model: UserModel.mock(), indent: 8, isFullScreen: false)
                .fixedSize(horizontal: true, vertical: false)
        }
    }
    
}

struct PadAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        PadAnswerView(model: AnswerModel.mock())
    }
}
