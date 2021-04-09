import XCTest
@testable import Markdown

final class MarkdownTests: XCTestCase {
    
    // MARK: - Neasted types
    
    typealias SnippetStep = Markdown.Unit.SnippetStep
    
    private enum Mock {
        
        static let markdownString = """
        How can I set a SwiftUI `Text` to display rendered HTML or Markdown?\r\n\r\nSomething like this:  \r\n    \r\n    Text(HtmlRenderedString(fromString: &quot;&lt;b&gt;Hi!&lt;/b&gt;&quot;))\r\nor for MD:  \r\n\r\n    Text(MarkdownRenderedString(fromString: &quot;**Bold**&quot;))\r\n\r\nPerhaps I need a different View?
        """
        
        static let codeString = "```swift\r\nlet mokeString = \"mokeString\"```"
        
        static let snippetString = """
        <!-- begin snippet: js hide: false console: true babel: false -->
        <!-- language: lang-html -->
        ```
        func convertHtml() -> NSAttributedString {
            guard let data = data(using: .utf8) else { return NSAttributedString() }
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                return attributedString
            } else {
                return NSAttributedString()
            }
        }
        ```
        <!-- end snippet -->
        """
    }
    
    // MARK: - Tests
    
    func testUnitInstance() {
        XCTAssertNotNil(Markdown.Unit(Mock.markdownString.htmlUnescape()))
    }

    func testParseCodeBlock() {
        guard let unit = Markdown.Unit(Mock.markdownString.htmlUnescape()) else {
            XCTFail("Unit is nil")
            return
        }
        let mokeSnippet = SnippetContainer()
        do {
            _ = try unit.configureCodeBlock(unit: unit, snippet: mokeSnippet, code: Mock.codeString)
        }
        catch {
            if let error = error as? SnippetStep {
                XCTAssertTrue(error == SnippetStep.isSnippetBody)
            } else {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testSnippetDetect() {
        guard let unit = Markdown.Unit(Mock.snippetString.htmlUnescape())?.children.first else {
            XCTFail("Snippet unit is nil")
            return
        }
        let mokeSnippet = SnippetContainer()
        
        unit.children.enumerated().forEach { children in
            switch unit.type {
            case .htmlBlock(let htmlText):
                do {
                   _ = try unit.configureHTMLBlock(
                        id: children.offset,
                        htmlContent: htmlText,
                        unit: unit,
                        snippet: mokeSnippet
                    )
                } catch {
                    guard let error = error as? SnippetStep else {
                        XCTFail("Unexpected error")
                        return
                    }
                    XCTAssertTrue(error == .beginSnippet || error == .isSnippet || error == .snippetIsEmpty || error == .snippetCodeType)
                }
            default:
                XCTFail("Moke not html")
            }
        }
    }
}
