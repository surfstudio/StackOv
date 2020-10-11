import SwiftUI

public extension EdgeInsets {
    
    static var zero: EdgeInsets {
        EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: .zero)
    }
    
    static func all(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: value, leading: value, bottom: value, trailing: value)
    }
    
    static func top(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: value, leading: .zero, bottom: .zero, trailing: .zero)
    }
    
    static func leading(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: .zero, leading: value, bottom: .zero, trailing: .zero)
    }
    
    static func bottom(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: .zero, leading: .zero, bottom: value, trailing: .zero)
    }
    
    static func trailing(_ value: CGFloat) -> EdgeInsets {
        EdgeInsets(top: .zero, leading: .zero, bottom: .zero, trailing: value)
    }
}
