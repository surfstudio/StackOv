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
    public let viewsNumber: Int
    public let answersNumber: Int
    public let votesNumber: Int
    public let tags: [String]
    public let link: URL?
    public let lastActivityDate: Date?
    public let creationDate: Date?
    public let acceptedAnswerId: Int?
    public let comments: [CommentModel]
    public let gradientColors: (top: Color, bottom: Color)
    public let avatar: URL?
}

// MARK: - Extensions

extension QuestionModel: Equatable {
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

public extension QuestionModel {
    
    var hasAcceptedAnswer: Bool {
        acceptedAnswerId != nil
    }

    var isEmpty: Bool {
        answersNumber == 0
    }
    
    var timeHasPassedSinceLastActivity: String {
        formatTimeHasPassed(since: lastActivityDate)
    }
    
    var timeHasPassedSinceCreation: String {
        formatTimeHasPassed(since: creationDate)
    }
    
    var formattedCreationDate: String {
        formatDate(creationDate)
    }
    
    var formattedLastActivityDate: String {
        formatDate(lastActivityDate)
    }
    
    var formattedVotesNumber: String {
        String.roundNumberWithAbbreviations(number: votesNumber)
    }
    
    var formattedViewsNumber: String {
        String.roundNumberWithAbbreviations(number: viewsNumber)
    }
    
    static func mock() -> QuestionModel {
        QuestionModel(
            id: 0,
            title: "How to make TouchableOpacity wrap its content when nested inside parent that has flex = 1",
            body: "How can I set a SwiftUI `Text` to display rendered HTML or Markdown?\r\n\r\nSomething like this:  \r\n    \r\n    Text(HtmlRenderedString(fromString: &quot;&lt;b&gt;Hi!&lt;/b&gt;&quot;))\r\nor for MD:  \r\n\r\n    Text(MarkdownRenderedString(fromString: &quot;**Bold**&quot;))\r\n\r\nPerhaps I need a different View?",
            viewsNumber: 207,
            answersNumber: 5,
            votesNumber: 15,
            tags: ["123", "perfomance", "microsoft-ui-automation", "css", "c++",
                   "123", "perfomance", "microsoft-ui-automation", "css", "c++"],
            link: URL(string: "google.com")!,
            lastActivityDate: Date(),
            creationDate: Date(),
            acceptedAnswerId: 0,
            comments: [],
            gradientColors: (.red, .blue),
            avatar: nil
        )
    }
}

// MARK: - Private extensions

fileprivate extension QuestionModel {
    
    func formatTimeHasPassed(since date: Date?) -> String {
        guard let date = date else {
            return ""
        }

        let distance = date.distance(to: Date())
        
        let timeString: String
        if distance < 86400 {
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .short
            formatter.allowedUnits = [.hour, .minute]
            guard let distanceString = formatter.string(from: distance) else {
                return ""
            }
            timeString = "\(distanceString) ago"
        } else if distance > 86400 && distance < 86400 * 31 {
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .short
            formatter.allowedUnits = [.day]
            guard let distanceString = formatter.string(from: distance) else {
                return ""
            }
            timeString = "\(distanceString) ago"
        } else if distance > 86400 * 31{
            let formatter = DateComponentsFormatter()
            formatter.unitsStyle = .full
            formatter.allowedUnits = [.year, .month]
            guard let distanceString = formatter.string(from: distance) else {
                return ""
            }
            timeString = "\(distanceString) ago"
        } else {
           timeString = formatDate(date)
        }
        
        return timeString
    }

    func formatDate(_ date: Date?) -> String {
        guard let date = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy, 'at' HH:mm"
        return formatter.string(from: date)
    }

}

// MARK: - Entry converter

extension QuestionModel {
    
    public static func from(entry: QuestionEntry, withGradientColors colors: (top: Color, bottom: Color)) -> QuestionModel {
        QuestionModel(
            id: entry.id,
            title: String(htmlString: entry.title) ?? entry.title,
            body: entry.body ?? "",
            viewsNumber: entry.viewCount,
            answersNumber: entry.answerCount,
            votesNumber: entry.score,
            tags: entry.tags,
            link: entry.link,
            lastActivityDate: entry.lastActivityDate,
            creationDate: entry.creationDate,
            acceptedAnswerId: entry.acceptedAnswerId,
            comments: entry.comments?.compactMap { CommentModel.from(entry: $0) } ?? [],
            gradientColors: colors,
            avatar: entry.owner?.avatar
        )
    }
}
