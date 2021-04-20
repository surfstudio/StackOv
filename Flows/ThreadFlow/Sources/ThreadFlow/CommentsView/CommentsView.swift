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

struct CommentsView: View {
    
    // MARK: - States
    
    @EnvironmentObject var store: CommentsStore
    
    // MARK: - Views
    
    var body: some View {
        LazyVStack {
            HStack {
                Text("Comments")
                Spacer()
                Button("Add comment") {
                    // TODO: Add functionality in the future
                }
            }
            ForEach(store.comments, id: \.commentId) { item in
                comment(model: item)
            }
            if (store.numberOfFollowingItems != 0) {
                Button("Show \(store.numberOfFollowingItems) more comment") {
                    store.showMore()
                }
            }
        }
    }
    
    // MARK: - View Methdos
    
    func comment(model: CommentModel) -> some View {
        VStack {
            HStack {
                if let score = model.score, score != 0 {
                    HStack {
                        Text("\(score)")
                            .font(.caption2)
                            .foregroundColor(Palette.slateGray)
                        Spacer()
                    }
                    .frame(width: 30)
                } else {
                    Spacer()
                        .frame(width: 30)
                }
                
                VStack(alignment: .leading) {
                    Text(model.body ?? "")
                        .font(.caption2)
                        .foregroundColor(Color.bodyColor)
                    HStack {
                        if let name = model.owner?.name {
                            Button(name) {
                                // TODO: Add functionality in the future
                            }
                            .foregroundColor(Palette.main)
                            .font(.caption2)
                        }
                        Text(model.formatCreationDate)
                            .font(.caption2)
                            .foregroundColor(Palette.slateGray)
                        if model.edited {
                            Icons.pencil.image.frame(width: 16, height: 16)
                        }
                    }
                    Divider()
                        .padding(.vertical, 10)
                }
            }
        }
    }
    
}

// MARK: - Colors

fileprivate extension Color {
    static let bodyColor: Color = .white | Palette.black
}

// MARK: - Previews

struct CommentsView_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
