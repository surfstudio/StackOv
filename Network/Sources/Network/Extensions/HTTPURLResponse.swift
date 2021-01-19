import Foundation

public extension HTTPURLResponse {
    
    var status: HTTPStatusCode? {
        HTTPStatusCode(rawValue: statusCode)
    }
}
