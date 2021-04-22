import Foundation
import Errors

public extension HTTPURLResponse {
    
    var status: HTTPStatusCode? {
        HTTPStatusCode(rawValue: statusCode)
    }
}
