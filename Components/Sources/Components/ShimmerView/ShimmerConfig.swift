//
//  [NAME].swift
//  StackOv ([NAME] module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Combine

public class ShimmerConfig: ObservableObject {
    
    // MARK: - Properties
    
    var bgColor: Color
    var fgColor: Color
    var shimmerColor: Color
    var shimmerAngle: Double
    var shimmerDuration: Double

    @Published internal var isActive: Bool = false

    // MARK: - Private Properties
    
    private var timer: AnyCancellable?
    
    // MARK: - Init & Deinit
    
    public init(bgColor: Color = Color(white: 0.8),
                fgColor: Color = .white,
                shimmerColor: Color = Color(white: 1.0, opacity: 0.5),
                shimmerAngle: Double = 20,
                shimmerDuration: TimeInterval = 1,
                shimmerDelay: TimeInterval = 2) {
        self.bgColor = bgColor
        self.fgColor = fgColor
        self.shimmerColor = shimmerColor
        self.shimmerAngle = shimmerAngle
        self.shimmerDuration = shimmerDuration

        self.timer =  Timer
               .publish(every: shimmerDelay, on: RunLoop.main, in: RunLoop.Mode.default)
               .autoconnect()
               .sink(receiveValue: { [weak self] _ in
            guard let self = self else { return }
            self.isActive = false
            
            withAnimation { self.isActive = true }
        })
    }
    
    deinit {
        timer?.cancel()
        timer = nil
    }
    
}

