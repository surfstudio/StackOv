//
//  QuestionItemModel.swift
//  This source file is part of the StackOv open source project
//

import Foundation
import struct SwiftUI.Color

struct QuestionItemModel: Identifiable {
    
    enum LastUpdateType {
        case asked(Date)
        case modified(Date)
        case answered(Date)
    }
    
    let id: UUID
    let title: String
    let isApproved: Bool
    let answersNumber: Int
    let votesNumber: Int
    let viewsNumber: Int
    let lastUpdateType: LastUpdateType
    let backgroundColors: (top: Color, bottom: Color)
    let tags: [String]
}

extension QuestionItemModel {
    
    var isEmpty: Bool {
        answersNumber == 0
    }
    
    var backgroundColorsList: [Color] {
        [backgroundColors.top, backgroundColors.bottom]
    }
    
    var formattedLastUpdate: String {
        let distance = lastUpdateType.date.distance(to: Date())
            
        let timeString: String
        if distance < 86400 {
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .short
            guard let distanceString = formatter.string(from: distance) else {
                return ""
            }
            timeString = "\(distanceString) ago"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, h:mm a"
            timeString = formatter.string(from: lastUpdateType.date)
        }

        switch lastUpdateType {
        case .answered:
            return "answered \(timeString)"
        case .asked:
            return "asked \(timeString)"
        case .modified:
            return "modified \(timeString)"
        }
    }
}

fileprivate extension QuestionItemModel.LastUpdateType {
    
    var date: Date {
        switch self {
        case let .answered(date):
            return date
        case let .asked(date):
            return date
        case let .modified(date):
            return date
        }
    }
}
