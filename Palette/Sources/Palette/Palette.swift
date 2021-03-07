// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
//

import SwiftUI

// MARK: - CoreColor

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
public typealias CoreColor = NSColor
#else
public typealias CoreColor = UIColor
#endif

public enum PaletteCore {

    public static var bluishblack: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "Bluishblack", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "Bluishblack", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "Bluishblack")!
        #endif
    }
    public static var dullGray: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "DullGray", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "DullGray", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "DullGray")!
        #endif
    }
    public static var gainsboro: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "Gainsboro", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "Gainsboro", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "Gainsboro")!
        #endif
    }
    public static var grayblue: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "Grayblue", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "Grayblue", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "Grayblue")!
        #endif
    }
    public static var main: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "Main", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "Main", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "Main")!
        #endif
    }
    public static var telegrey: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "Telegrey", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "Telegrey", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "Telegrey")!
        #endif
    }

}

// MARK: - Palette

public enum Palette {

    public static var bluishblack: Color { .init(PaletteCore.bluishblack) }
    public static var dullGray: Color { .init(PaletteCore.dullGray) }
    public static var gainsboro: Color { .init(PaletteCore.gainsboro) }
    public static var grayblue: Color { .init(PaletteCore.grayblue) }
    public static var main: Color { .init(PaletteCore.main) }
    public static var telegrey: Color { .init(PaletteCore.telegrey) }

}

// MARK: - Extensions

public extension CoreColor {

    /// Easily define two colors for both light and dark mode
    /// Link: https://www.avanderlee.com/swift/dark-mode-support-ios/
    ///
    /// - Parameters:
    ///   - lightColor: The color to use in light mode
    ///   - darkColor: The color to use in dark mode
    /// - Returns: A dynamic color that uses both given colors respectively for the given user interface style
    static func | (lightColor: CoreColor, darkColor: CoreColor) -> CoreColor {
        CoreColor { $0.userInterfaceStyle == .light ? lightColor : darkColor }
    }
}

public extension Color {

    /// Easily define two colors for both light and dark mode
    ///
    /// - Parameters:
    ///   - lightColor: The color to use in light mode
    ///   - darkColor: The color to use in dark mode
    /// - Returns: A dynamic color that uses both given colors respectively for the given user interface style
    static func | (lightColor: Color, darkColor: Color) -> Color {
        Color(CoreColor(lightColor) | CoreColor(darkColor))
    }
}
