import XCTest
import Common
@testable import AuthManager

final class AuthManagerTests: XCTestCase {
    
    func testAccessTokenExtractor() {
        do {
            let config = try StackexchangeAuthConfigurations.load()
            let manager = AuthManager(configurations: config)
            let tokenValue = "{access_token_value}"
            let url: URL = {
                var components = URLComponents(url: config.redirectUri, resolvingAgainstBaseURL: true)!
                components.fragment = "access_token=\(tokenValue)"
                return components.url!
            }()
            
            let extractedToken = try manager.extractToken(fromUrl: url)
            XCTAssertEqual(tokenValue, extractedToken)
        } catch {
            XCTFail("Preinstall error: \(error)")
        }
    }
}
