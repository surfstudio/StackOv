//
//  LoaderCircle.swift
//  StackOv (Components module)
//
//  Created by Илья Князьков
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Palette

struct LoaderCircle: View {

    // MARK: - Nested types

    private enum Constants {
        static let trimEnd: CGFloat = 0.8
        static let lineWidth: CGFloat = 3
    }

    // MARK: - Private properties

    private var gradient: AngularGradient {
        AngularGradient(gradient: Gradient(colors: [.clear, .loaderLineColor]), center: .center)
    }

    // MARK: - View

    var body: some View {
        Circle()
            .trim(from: .zero, to: Constants.trimEnd)
            .stroke(gradient, lineWidth: Constants.lineWidth)
    }
}

// MARK: - Colors

fileprivate extension Color {

    static let loaderLineColor = Palette.paleSky
}
