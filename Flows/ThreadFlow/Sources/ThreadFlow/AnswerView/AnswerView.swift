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
    @EnvironmentObject var store: ThreadStore
    
    // MARK: - Properties

    let model: AnswerModel
    let isLast: Bool
    
    // MARK: - Views
    
    var body: some View {
        VStack(spacing: .zero) {
            if UIDevice.current.userInterfaceIdiom.isPad && horizontalSizeClass == .regular {
                PadAnswerView(model: model)
                    .environmentObject(store)
            } else {
                PhoneAnswerView(model: model)
                    .environmentObject(store)
            }
            
            VStack(spacing: .zero) {
                Divider()
                    .padding(.top, 24)
                    .padding(.bottom, 8)
                
                if model.comments.count > 0 {
                    CommentsView(isNeedShowButton: false)
                        .environmentObject(StoresAssembler.shared.resolve(CommentsStore.self, argument: model.comments)!)
                }
            }.padding(.leading, 60)
            
            if !isLast {
                Divider()
                    .padding(.vertical, 32)
            }
        }
    }
    
}

// MARK: - Previews

struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(model: AnswerModel.mock(), isLast: true)
    }
}
