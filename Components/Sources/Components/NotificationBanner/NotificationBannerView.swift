//
//  [NAME].swift
//  StackOv ([NAME] module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI

public struct NotificationBannerView: View {
    
    // MARK: - States
    
    @Binding var data: NotificationBannerData
    
    // MARK: - Views
    
    public var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(data.title)
                        .bold()
                    Text(data.description)
                }
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .background(data.color)
            .cornerRadius(8)
            Spacer()
        }
        .padding()
    }
    
    // MARK: - Initialization
    
    public init(data: Binding<NotificationBannerData>) {
        self._data = data
    }
    
}

struct NotificationBannerView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationBannerView(data: .constant(NotificationBannerData(title: "Title", description: "Description", color: .red)))
    }
}
