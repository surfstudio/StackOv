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
    
    // MARK: - Properties
    
    let model: QuestionModel
    
    // MARK: - View
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(model.title)
                .font(.title2)
                .fontWeight(.bold)
            
            #if DEBUG
            HStack(spacing: 24) {
                Text("Asked 9 years, 6 months ago")
                Text("Active today")
                Text("Viewed 817k times")
            }
            .font(.caption)
            #endif
            
            Divider()
            
            HStack(alignment: .top, spacing: .zero) {
                if UIDevice.current.userInterfaceIdiom.isPad {
                    HStack(alignment: .center, spacing: .zero) {
                        RetingView()
                    }
                    .frame(width: 60)
                }
                
                MarkdownPostView(text: .constant(model.body))
            }
        }
    }
}

fileprivate struct RetingView: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Button(action: {}, icon: .handThumbsupFill)
                .frame(width: 24, height: 24)
            Text("363")
                .font(.subheadline)
            Button(action: {}, icon: .handThumbsdownFill)
                .frame(width: 24, height: 24)
        }
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(model: QuestionModel.mock())
    }
}

