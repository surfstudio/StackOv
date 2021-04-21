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
        VStack(alignment: .leading) {
            HStack {
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
            }.padding(.bottom, 34)
            
            ForEach(store.comments, id: \.commentId) { item in
                comment(model: item)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            if (store.numberOfFollowingItems != 0) {
                Button("Show \(store.numberOfFollowingItems) more comment") {
                    store.showMore()
                }
                .font(.footnote)
                .foregroundColor(Palette.main)
                .padding(.leading, 45)
            }
        }
    }
    
    // MARK: - View Methdos
    
    func comment(model: CommentModel) -> some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                if let score = model.score, score != 0 {
                    HStack {
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
                
                VStack(alignment: .leading) {
                    MarkdownPostView(text: .constant(model.body ?? ""))
                        .font(.footnote)
                        .foregroundColor(Color.bodyColor)
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
                }
            }
            Divider()
                .padding(.vertical, 10)
        }
    }
    
}

// MARK: - Colors

fileprivate extension Color {
    static let bodyColor: Color = Palette.black | .white
    static let headerColor: Color = Palette.black | Color.white.opacity(0.7)
}

// MARK: - Previews

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
