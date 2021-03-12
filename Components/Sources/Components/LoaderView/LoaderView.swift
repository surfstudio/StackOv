//
//  LoaderView.swift
//  StackOv (Components module)
//
//  Created by Илья Князьков
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public struct LoaderView: View, Animatable {

    // MARK: - Nested types

    private enum Constants {
        static let animationDuration: Double = 0.3
    }

    // MARK: - Public properties

    public var animatableData: Double {
        get { rotationAngle }
        set { rotationAngle = newValue }
    }

    @State var rotationAngle: Double = 0

    // MARK: - Private properties

    private var animation: Animation {
        Animation.linear(duration: Constants.animationDuration)
            .repeatForever(autoreverses: false)
    }


    // MARK: - Initializers

    public init() { }


    // MARK: - View

    public var body: some View {
        LoaderCircle()
            .rotationEffect(Angle(degrees: rotationAngle))
            .animation(animation)
            .onAppear {
                rotationAngle = 360
            }
    }
}

// MARK: - LiveView

struct LoaderView_Previews: PreviewProvider {

    static var previews: some View {
        LoaderView()
    }
}
