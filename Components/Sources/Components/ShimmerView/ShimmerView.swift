//
//  [NAME].swift
//  StackOv ([NAME] module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

struct ShimmerView : View {
    
    // MARK: - States
    
    @EnvironmentObject private var shimmerConfig: ShimmerConfig
        
    // MARK: - View
    
    var body: some View {
        let startGradient = Gradient.Stop(color: self.shimmerConfig.bgColor, location: 0.3)
        let endGradient = Gradient.Stop(color: self.shimmerConfig.bgColor, location: 0.7)
        let maskGradient = Gradient.Stop(color: self.shimmerConfig.shimmerColor, location: 0.5)
        
        let gradient = Gradient(stops: [startGradient, maskGradient, endGradient])
        
        let linearGradient = LinearGradient(gradient: gradient,
                                            startPoint: .leading,
                                            endPoint: .trailing)
            
        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .background(self.shimmerConfig.bgColor)
                    .foregroundColor(.clear)
                Rectangle()
                    .foregroundColor(.clear)
                    .background(linearGradient)
                    .rotationEffect(Angle(degrees: self.shimmerConfig.shimmerAngle))
                    .offset(x: self.shimmerConfig.isActive ? self.shimmerOffset(geometry.size.width) : -self.shimmerOffset(geometry.size.width), y: 0)
                    .transition(.move(edge: .leading))
                    .animation(.linear(duration: self.shimmerConfig.shimmerDuration))
            }
            .padding(EdgeInsets(top: -self.shimmerOffset(geometry.size.width),
                                leading: 0,
                                bottom: -self.shimmerOffset(geometry.size.width),
                                trailing: 0))
        }
    }
    
    // MARK: - Methods
    
    func shimmerOffset(_ width: CGFloat) -> CGFloat {
        width + CGFloat(2 * self.shimmerConfig.shimmerAngle)
    }
    
}
