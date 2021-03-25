//
//  ShimmerView.swift
//  StackOv (Components module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Common

struct ShimmerView : View {
    
    // MARK: - States
    
    @EnvironmentObject var shimmerConfig: ShimmerConfig
    
    // MARK: - Properties
    
    var linearGradient: LinearGradient {
        let startGradient = Gradient.Stop(color: shimmerConfig.bgColor, location: 0.3)
        let endGradient = Gradient.Stop(color: shimmerConfig.bgColor, location: 0.7)
        let maskGradient = Gradient.Stop(color: shimmerConfig.shimmerColor, location: 0.5)
        let gradient = Gradient(stops: [startGradient, maskGradient, endGradient])
        return LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing)
    }

    // MARK: - View
    
    var body: some View {
        GeometryReader {
            content(shimmerOffset: $0.size.width + CGFloat(2 * shimmerConfig.shimmerAngle))
        }
    }
    
    // MARK: - View methods
    
    func content(shimmerOffset: CGFloat) -> some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .background(shimmerConfig.bgColor)
                .foregroundColor(.clear)
            
            Rectangle()
                .foregroundColor(.clear)
                .background(linearGradient)
                .rotationEffect(Angle(degrees: shimmerConfig.shimmerAngle))
                .offset(x: (shimmerConfig.isActive ? 1 : -1) * shimmerOffset, y: .zero)
                .transition(.move(edge: .leading))
                .animation(.linear(duration: shimmerConfig.shimmerDuration))
        }
        .padding(.vertical(-shimmerOffset))
    }
}
