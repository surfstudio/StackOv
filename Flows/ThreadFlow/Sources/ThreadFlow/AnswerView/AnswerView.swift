//
//  AnswerView.swift
//  StackOv (ThreadFlow module)
//
//  Created by Влад Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Common
import AppScript

struct AnswerView: View {
    
    // MARK: - States
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    // MARK: - Properties

    var model: AnswerModel
    
    // MARK: - Views
    
    var body: some View {
        VStack {
            if UIDevice.current.userInterfaceIdiom.isPad && horizontalSizeClass == .regular {
                PadAnswerView(model: model)
            } else {
                PhoneAnswerView(model: model)
            }
            
            Divider()
                .padding(.vertical, 24)
            if model.comments.count > 0 {
                CommentsView(isNeedShowButton: false)
                    .environmentObject(StoresAssembler.shared.resolve(CommentsStore.self, argument: model.comments)!)
            }
        }
    }
    
}

// MARK: - Previews

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(model: AnswerModel.mock())
    }
}
