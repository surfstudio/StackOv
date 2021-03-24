//
//  NotificationBannerView.swift
//  StackOv (Components module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Icons
import Palette

public struct NotificationBannerView: View {
    
    // MARK: - Private Properties
    
    private var buttonAction: () -> Void
    
    // MARK: - States
    
    @Binding var data: NotificationBannerData
    
    // MARK: - Views
    
    public var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text(data.title)
                            .bold()
                            .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 0))
                            .foregroundColor(data.bunnerType.textColor)
                        Spacer()
                        Button(action: {
                            self.buttonAction()
                        }) {
                            Icons.xmark.image
                                .foregroundColor(data.bunnerType.iconColor)
                        }
                        .frame(width: 18, height: 18, alignment: .center)
                        .background(Palette.lightGray | Color.white.opacity(0.7))
                        .cornerRadius(9)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 11))
                    }
                    Text(data.description)
                        .padding(.init(top: 0, leading: 20, bottom: 20, trailing: 20))
                        .foregroundColor(data.bunnerType.textColor)
                }
            }
            .foregroundColor(.white)
            .background(data.bunnerType.backgroundColor)
            .cornerRadius(14)
            .shadow(color: Color.black.opacity(0.12), radius: 14, x: 0, y: 4)
            Spacer()
        }
        .padding(12)
    }
    
    // MARK: - Initialization
    
    public init(data: Binding<NotificationBannerData>, action: @escaping () -> Void) {
        self._data = data
        self.buttonAction = action
    }
    
}

struct NotificationBannerView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationBannerView(data: .constant(NotificationBannerData(title: "Title", description: "Description", bunnerType: .error)), action: {})
    }
}
