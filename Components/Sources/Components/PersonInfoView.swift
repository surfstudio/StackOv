//
//  PersonInfoView.swift
//  StackOv (Components module)
//
//  Created by Владислав Климов
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import SwiftUI
import Common
import Icons
import Palette

public struct PersonInfoView: View {
    
    // MARK: - Properties
    
    var model: UserModel
    var indent: CGFloat
    var isFullScreen: Bool
    
    // MARK: - Initialization
    
    public init (model: UserModel, indent: CGFloat = 8, isFullScreen: Bool = false) {
        self.model = model
        self.indent = indent
        self.isFullScreen = isFullScreen
    }
    
    // MARK: - View
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                header
                footer
            }
            .padding(.all, indent)
            
            if isFullScreen {
                Spacer()
            }

        }
        .background(Color.backroundColor)
        .cornerRadius(10)
    }
    
    var header: some View {
        HStack {
            Text(model.actionType.rawValue)
            Text(model.formattedActionDate)
        }
        .font(.caption2)
        .foregroundColor(Color.timeInfoColor)
    }
    
    var footer: some View {
        HStack(alignment: .bottom, spacing: 8) {
            Rectangle()
                .background(Color.red)
//                Image("kek")
                .frame(width: 36, height: 36)
                .cornerRadius(18)
            VStack(alignment: .leading, spacing: 5) {
                Text(model.displayName)
                    .foregroundColor(Color.displayNameColor)
                    .font(.subheadline)
                HStack {
                    Text(model.formattedReputationDate)
                        .font(.caption2)
                        .foregroundColor(Color.statisticsColor)
                        .fixedSize()
                    bagesView(bageType: .gold, number: model.goldBadges)
                    bagesView(bageType: .silver, number: model.silverBadges)
                    bagesView(bageType: .bronze, number: model.bronzeBadges)
                }
            }
        }
    }
    
    // MARK: - View Methods
    
    @ViewBuilder
    private func bagesView(bageType: BagesType, number: Int) -> some View {
        if (number > 0) {
            HStack(alignment: .center, spacing: 3) {
                switch bageType {
                case .gold:
                    Icons.crownCircleGoldFill.image
                        .frame(width: 12, height: 12)
                case .silver:
                    Icons.crownCircleSilverFill.image
                        .frame(width: 12, height: 12)
                case .bronze:
                    Icons.crownCircleBronzeFill.image
                        .frame(width: 12, height: 12)
                }
                Text(model.formattedBagesNumber(number: number))
                    .foregroundColor(Color.statisticsColor)
                    .font(.caption2)
            }.fixedSize()
        } else {
            EmptyView()
        }
    }
    
}

// MARK: - Colors

fileprivate extension Color {
    static let backroundColor: Color =  Palette.periwinkleCrayola | Color.white.opacity(0.04)
    static let timeInfoColor: Color = Palette.slateGray | Color.white.opacity(0.5)
    static let displayNameColor: Color = Palette.black | Color.white
    static let statisticsColor: Color = Palette.slateGray | Palette.gainsboro
}

// MARK: - Nested Types

fileprivate enum BagesType {
    case gold
    case silver
    case bronze
}

// MARK: - Preview

struct PersonInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PersonInfoView(model: UserModel.mock())
    }
}
