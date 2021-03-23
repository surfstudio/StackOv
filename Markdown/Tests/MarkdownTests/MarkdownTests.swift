import XCTest
@testable import Markdown

final class MarkdownTests: XCTestCase {

    let mokeMarkdownInString = """
        How can I set a SwiftUI `Text` to display rendered HTML or Markdown?\r\n\r\nSomething like this:  \r\n    \r\n    Text(HtmlRenderedString(fromString: &quot;&lt;b&gt;Hi!&lt;/b&gt;&quot;))\r\nor for MD:  \r\n\r\n    Text(MarkdownRenderedString(fromString: &quot;**Bold**&quot;))\r\n\r\nPerhaps I need a different View?
        """
    let mokeCodeInString = "```swift\r\nlet mokeString = \"mokeString\"```"
    
    func testUnitInstance() {
        XCTAssertNotNil(Markdown.Unit(mokeMarkdownInString.htmlUnescape()))
    }

    func testParseCodeBlock() {
        guard let unit = Markdown.Unit(mokeMarkdownInString.htmlUnescape()) else {
            XCTFail("Unit is nil!")
            return
        }
        let mokeSnippet = SnippetContainer()
        do {
            _ = try unit.configureCodeBlock(unit: unit, snippet: mokeSnippet, code: mokeCodeInString)
        }
        catch {
            if let error = error as? UnitErrors {
                XCTAssertTrue(error == UnitErrors.isSnippetBody)
            } else {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testSnippetDetect() {
        guard let unit = Markdown.Unit(mokeMarkdownInString.htmlUnescape()) else {
            XCTFail("Unit is nil!")
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
                    guard let error = error as? UnitErrors else {
                        XCTFail("Unexpected error!")
                        return
                    }
                    XCTAssertTrue(error == .beginSnippet || error == .isSnippet || error == .snippetIsEmpty || error == .snippetType)
                }
            default:
                XCTFail("Moke not html!")
            }
        }
        
    }
}
