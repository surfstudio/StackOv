//
//  QuestionView.swift
//  StackOv (ThreadFlow module)
//
//  Created by Erik Basargin
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
        VStack(alignment: .leading, spacing: 20) {
            Text(model.title)
                .font(.title2)
                .fontWeight(.bold)
            
            HStack(spacing: 24) {
                Text("Asked \(model.timeHasPassedSinceCreation)")
                    .foregroundColor(Color.subheadings)

                Text("Active ")
                    .foregroundColor(Color.subheadings)
                    + Text(model.timeHasPassedSinceLastActivity)
                        .foregroundColor(Color.text)

                Text("Viewed ")
                    .foregroundColor(Color.subheadings)
                    + Text ("\(model.formattedViewsNumber) times")
                        .foregroundColor(Color.text)
            }
            .font(.caption)
            
            Divider()
                .padding(.top, 4)
            
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

fileprivate extension Color {
    
    static var subheadings: Color = Palette.slateGray | Color.white.opacity(0.7)
    static var text: Color = Palette.black | .white

}
