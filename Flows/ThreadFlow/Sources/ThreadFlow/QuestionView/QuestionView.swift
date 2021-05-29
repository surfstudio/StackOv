//
//  QuestionView.swift
//  StackOv (ThreadFlow module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette
import Common
import Components
import Icons
import AppScript

struct QuestionView: View {
    
    // MARK: - States
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var store: ThreadStore
    
    // MARK: - Properties
    
    let model: QuestionModel
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: .zero){
            if UIDevice.current.userInterfaceIdiom.isPad && horizontalSizeClass == .regular {
                PadQuestionView(model: model)
                    .environmentObject(store)
            } else {
                PhoneQuestionView(model: model)
                    .environmentObject(store)
            }
            
            VStack(spacing: .zero) {
                Divider()
                    .padding(.top, 24)
                    .padding(.bottom, 8)
                
                if model.comments.count > 0 {
                    CommentsView()
                        .environmentObject(StoresAssembler.shared.resolve(CommentsStore.self, argument: model.comments)!)
                }
            }.padding(.leading, 60)
        }
    }
}

// MARK: - Previews

struct QuestionView_Previews: PreviewProvider {
    
    static var previews: some View {
        QuestionView(model: QuestionModel.mock())
    }
}
