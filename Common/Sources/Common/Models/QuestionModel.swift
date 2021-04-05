//
//  QuestionModel.swift
//  StackOv (Common module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import Foundation
import struct DataTransferObjects.QuestionEntry
import struct SwiftUI.Color

public struct QuestionModel: Identifiable {
    
    public let id: Int
    public let title: String
    public let body: String
    public let hasAcceptedAnswer: Bool
    public let viewsNumber: Int
    public let answersNumber: Int
    public let votesNumber: Int
    public let tags: [String]
    public let link: URL
    public let lastActivity: PostActivity
    public let gradientColors: (top: Color, bottom: Color)
}

// MARK: - Extensions

extension QuestionModel: Equatable {
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

public extension QuestionModel {
    
    var isEmpty: Bool {
        answersNumber == 0
    }
    
    var formattedLastActivity: String {
        let distance = lastActivity.date.distance(to: Date())
        
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
            timeString = formatter.string(from: lastActivity.date)
        }
        
        switch lastActivity {
        case .answered:
            return "answered \(timeString)"
        case .asked:
            return "asked \(timeString)"
        case .modified:
            return "modified \(timeString)"
        }
    }
    
    static func mock() -> QuestionModel {
        QuestionModel(
            id: 0,
            title: "How to make TouchableOpacity wrap its content when nested inside parent that has flex = 1",
            body: "How can I set a SwiftUI `Text` to display rendered HTML or Markdown?\r\n\r\nSomething like this:  \r\n    \r\n    Text(HtmlRenderedString(fromString: &quot;&lt;b&gt;Hi!&lt;/b&gt;&quot;))\r\nor for MD:  \r\n\r\n    Text(MarkdownRenderedString(fromString: &quot;**Bold**&quot;))\r\n\r\nPerhaps I need a different View?",
            hasAcceptedAnswer: true,
            viewsNumber: 207,
            answersNumber: 5,
            votesNumber: 15,
            tags: ["123", "perfomance", "microsoft-ui-automation", "css", "c++",
                   "123", "perfomance", "microsoft-ui-automation", "css", "c++"],
            link: URL(string: "google.com")!,
            lastActivity: .asked(Date()),
            gradientColors: (.red, .blue)
        )
    }
}

// MARK: - Entry converter

extension QuestionModel {
    
    public static func from(entry: QuestionEntry,
                     withGradientColors colors: (top: Color, bottom: Color)) -> QuestionModel {
        QuestionModel(
            id: entry.id,
            title: String(htmlString: entry.title) ?? entry.title,
            body: entry.body ?? "",
            hasAcceptedAnswer: entry.acceptedAnswerId != nil,
            viewsNumber: entry.viewCount,
            answersNumber: entry.answerCount,
            votesNumber: entry.score,
            tags: entry.tags,
            link: entry.link,
            lastActivity: .answered(Date()), // FIXIT: - Need update service layer
            gradientColors: colors
        )
    }
}
