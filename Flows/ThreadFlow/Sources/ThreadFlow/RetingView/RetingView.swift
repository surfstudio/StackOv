//
//  RetingView.swift
//  StackOv (ThreadFlow module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct RetingView: View {
    
    // MARK: - Properties
    
    var viewed: String
    var isVertical: Bool
    
    // MARK: - View
    
    var body: some View {
        Group {
            Button(action: {}, icon: .handThumbsupFill)
                .frame(width: 24, height: 24)
            Text(viewed)
                .font(.footnote)
            Button(action: {}, icon: .handThumbsdownFill)
                .frame(width: 24, height: 24)
        }
        .stack(axis: isVertical ? .vertical : .horizontal, spacing: isVertical ? 8 : 12)
        .foregroundColor(Palette.slateGray | Palette.dullGray)
    }
}

// MARK: - View Modifiers

fileprivate struct StackModifier: ViewModifier {
    
    enum Axis {
        case vertical
        case horizontal
    }
    
    let axis: Axis
    let spacing: CGFloat?
    
    @ViewBuilder
    func body(content: Content) -> some View {
        switch axis {
        case .vertical:
            VStack(alignment: .center, spacing: spacing) {
                content
            }
        case .horizontal:
            HStack(alignment: .center, spacing: spacing) {
                content
            }
        }
    }
}

// MARK: - Extensions

fileprivate extension View {
    
    func stack(axis: StackModifier.Axis, spacing: CGFloat? = nil) -> some View {
        modifier(StackModifier(axis: axis, spacing: spacing))
    }
}

// MARK: - Previews

struct RetingView_Previews: PreviewProvider {
    
    static var previews: some View {
        RetingView(viewed: "365", isVertical: false)
    }
}
