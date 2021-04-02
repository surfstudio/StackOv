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
    
    // MARK: - Properties
    
    let model: QuestionModel
    
    // MARK: - View
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom.isPad && horizontalSizeClass == .regular {
            PadQuestionView(model: model)
        } else {
            PhoneQuestionView(model: model)
        }
    }
}

// MARK: - Previews

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(model: QuestionModel.mock())
    }
}
