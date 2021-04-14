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
import Common

public struct NotificationBannerView: View {
    
    // MARK: - States
    
    @Binding var model: NotificationBannerModel
    
    // MARK: - Properties
    
    let buttonActionWithId: ((UUID) -> Void)?
    let buttonAction: (() -> Void)?
    
    // MARK: - Initialization
    
    public init(model: Binding<NotificationBannerModel>, action: @escaping (UUID) -> Void) {
        self._model = model
        self.buttonActionWithId = action
        self.buttonAction = nil
    }
    
    public init(model: Binding<NotificationBannerModel>, action: @escaping () -> Void) {
        self._model = model
        self.buttonAction = action
        self.buttonActionWithId = nil
    }
    
    // MARK: - View
    
    public var body: some View {
        VStack {
            HStack {
                content
            }
            .background(model.style.backgroundColor)
            .cornerRadius(14)
            .shadow(color: Color.contentShadow, radius: 14, x: 0, y: 4)
            
            Spacer()
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(model.title)
                    .bold()
                    .padding(.top, 20)
                    .padding(.leading, 20)
                    .foregroundColor(model.style.textColor)
                
                Spacer()
                
                Button {
                    buttonActionWithId?(model.id)
                    buttonAction?()
                }
                    label: {
                    Icons.xmark.image
                        .foregroundColor(model.style.iconColor)
                }
                .frame(width: 18, height: 18, alignment: .center)
                .background(Color.xmarkButtonBackground)
                .cornerRadius(9)
                .padding(.trailing, 11)
            }
            
            Text(model.description ?? "")
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .foregroundColor(model.style.textColor)
        }
    }
}

// MARK: - Previews

struct NotificationBannerView_Previews: PreviewProvider {
    
    static var previews: some View {
        let model = NotificationBannerModel(title: "Title", description: "Description", style: .error)
        return NotificationBannerView(model: .constant(model), action: {})
    }
}

// MARK: - Colors

fileprivate extension Color {
    
    static let contentShadow = Color.black.opacity(0.12)
    static let xmarkButtonBackground = Palette.lightGray | Color.white.opacity(0.7)
}

// MARK: - Extensions

fileprivate extension NotificationBannerStyle {
    
    var backgroundColor: Color {
        switch self {
        case .info:
            return Palette.bluishwhite | Palette.grayblue
        case .success:
            return Palette.main
        case .error:
            return Palette.red
        }
    }
    
    var buttonColor: Color {
        switch self {
        case .info:
            return Palette.gray | Palette.dullGray
        case .success, .error:
            return Color.white.opacity(0.7)
        }
    }
    
    var iconColor: Color {
        switch self {
        case .success, .error:
            return backgroundColor
        case .info:
            return Palette.steelGray300 | backgroundColor
        }
    }
    
    var textColor: Color {
        switch self {
        case .info:
            return Palette.black | .white
        case .error, .success:
            return .white
        }
    }
}
