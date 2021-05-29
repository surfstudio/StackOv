//
//  CommentsView.swift
//  StackOv (ThreadFlow module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Common
import Palette
import Icons
import AppScript
import Components

struct CommentsView: View {
    
    // MARK: - States
    
    @EnvironmentObject var store: CommentsStore
    
    // MARK: - Properties
    
    let isNeedShowButton: Bool
    
    // MARK: - Initialization
    
    init(isNeedShowButton: Bool = true) {
        self.isNeedShowButton = isNeedShowButton
    }
    
    // MARK: - Views
    
    var body: some View {
        VStack(alignment: .leading, spacing: .zero) {
            HStack(spacing: .zero) {
                Text("Comments")
                    .foregroundColor(Color.headerColor)
                    .font(.headline)
                Spacer()
                
                if isNeedShowButton {
                    Button("Add comment") {
                        // TODO: Add functionality in the future
                    }
                    .foregroundColor(Palette.main)
                    .font(.subheadline)
                }
            }
            .frame(height: 62)
            .padding(.bottom, 10)
            
            ForEach(store.comments) { item in
                comment(model: item, isLast: item == store.comments.last)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            if store.numberOfFollowingItems != .zero {
                Button(action: { store.showMore() }) {
                    Text("Show \(store.numberOfFollowingItems) more comment")
                    Spacer()
                }
                .frame(height: 48)
                .font(.footnote)
                .foregroundColor(Palette.main)
                .padding(.leading, 45)
            }
        }
    }
    
    // MARK: - View Methdos
    
    func comment(model: CommentModel, isLast: Bool) -> some View {
        HStack(alignment: .top, spacing: .zero) {
            if let score = model.score, score != .zero {
                HStack(spacing: .zero) {
                    Text("\(score)")
                        .font(.footnote)
                        .foregroundColor(Palette.slateGray)
                    Spacer()
                }
                .frame(width: 45)
            } else {
                Spacer()
                    .frame(width: 45)
            }
            
            VStack(alignment: .leading, spacing: .zero) {
                MarkdownPostView(store.unit(of: model), style: .comment)
                
                HStack {
                    if let name = model.owner?.name {
                        Button(name) {
                            // TODO: Add functionality in the future
                        }
                        .font(.footnote)
                        .foregroundColor(Palette.main)
                    }
                    Text(model.formattedCreationDate)
                        .font(.footnote)
                        .foregroundColor(Palette.slateGray)
                    if model.edited {
                        Icons.pencil.image.frame(width: 16, height: 16)
                    }
                }.padding(.top, 8)
                
                if !isLast {
                    Divider()
                        .padding(.vertical, 10)
                }
            }
        }
    }
    
}

// MARK: - Colors

fileprivate extension Color {

    static let headerColor: Color = Palette.black | Color.white.opacity(0.7)
}

// MARK: - Previews

struct CommentsView_Previews: PreviewProvider {
    
    static var previews: some View {
        CommentsView()
    }
}
