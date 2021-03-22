//
//  [NAME].swift
//  StackOv ([NAME] module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public struct NotificationBannerModifier: ViewModifier {
    
    // MARK: - Properties
    
    @Binding var show: Bool
    @Binding var bannerData: NotificationBannerData
    
    // MARK: - Views
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            NotificationBannerView(data: $bannerData)
        }
        .animation(.easeInOut)
        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                withAnimation {
                    self.show = false
                }
            })
        })
    }
    
}
