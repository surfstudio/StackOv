// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
//

import SwiftUI

// MARK: - PaletteCore

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
public typealias PaletteCore = NSColor
#else
public typealias PaletteCore = UIColor
#endif

public extension PaletteCore {

    static var bluishblack: Self {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return Self(named: "Bluishblack", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return Self(named: "Bluishblack", bundle: bundle)!
        #elseif os(watchOS)
        return Self(named: "Bluishblack")!
        #endif
    }
    static var dullGray: Self {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return Self(named: "DullGray", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return Self(named: "DullGray", bundle: bundle)!
        #elseif os(watchOS)
        return Self(named: "DullGray")!
        #endif
    }
    static var gainsboro: Self {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return Self(named: "Gainsboro", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return Self(named: "Gainsboro", bundle: bundle)!
        #elseif os(watchOS)
        return Self(named: "Gainsboro")!
        #endif
    }
    static var grayblue: Self {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return Self(named: "Grayblue", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return Self(named: "Grayblue", bundle: bundle)!
        #elseif os(watchOS)
        return Self(named: "Grayblue")!
        #endif
    }
    static var main: Self {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return Self(named: "Main", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return Self(named: "Main", bundle: bundle)!
        #elseif os(watchOS)
        return Self(named: "Main")!
        #endif
    }
    static var telegrey: Self {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return Self(named: "Telegrey", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return Self(named: "Telegrey", bundle: bundle)!
        #elseif os(watchOS)
        return Self(named: "Telegrey")!
        #endif
    }

}

// MARK: - Palette

public typealias Palette = Color

public extension Palette {

    static let bluishblack = { Self(.bluishblack) }()
    static let dullGray = { Self(.dullGray) }()
    static let gainsboro = { Self(.gainsboro) }()
    static let grayblue = { Self(.grayblue) }()
    static let main = { Self(.main) }()
    static let telegrey = { Self(.telegrey) }()

}

// MARK: - Extensions

public extension PaletteCore {

    /// Easily define two colors for both light and dark mode
    /// Link: https://www.avanderlee.com/swift/dark-mode-support-ios/
    ///
    /// - Parameters:
    ///   - lightColor: The color to use in light mode
    ///   - darkColor: The color to use in dark mode
    /// - Returns: A dynamic color that uses both given colors respectively for the given user interface style
    static func | (lightColor: PaletteCore, darkColor: PaletteCore) -> PaletteCore {
        PaletteCore { $0.userInterfaceStyle == .light ? lightColor : darkColor }
    }
}

public extension Palette {

    /// Easily define two colors for both light and dark mode
    ///
    /// - Parameters:
    ///   - lightColor: The color to use in light mode
    ///   - darkColor: The color to use in dark mode
    /// - Returns: A dynamic color that uses both given colors respectively for the given user interface style
    static func | (lightColor: Palette, darkColor: Palette) -> Palette {
        Palette(PaletteCore(lightColor) | PaletteCore(darkColor))
    }
}
