//
//  ShimmerConfig.swift
//  StackOv (Components module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Combine

public class ShimmerConfig: ObservableObject {
    
    // MARK: - States
    
    @Published var isActive: Bool = false
    
    // MARK: - Properties
    
    let bgColor: Color
    let fgColor: Color
    let shimmerColor: Color
    let shimmerAngle: Double
    let shimmerDuration: TimeInterval
    let shimmerDelay: TimeInterval

    // MARK: - Private Properties
    
    private var timer: AnyCancellable?
    
    // MARK: - Initialization and deinitialization

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
        self.shimmerDelay = shimmerDelay
    }
    
    deinit {
        stopAnimation()
    }
    
    // MARK: - Public methods
    
    public func startAnimation() {
        stopAnimation()
        timer?.cancel()
        timer = Timer
            .publish(every: shimmerDelay, on: .main, in: .default)
            .autoconnect()
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.isActive = false
                withAnimation { self.isActive = true }
            })
    }
    
    public func stopAnimation() {
        timer?.cancel()
        timer = nil
        isActive = false
    }
}

