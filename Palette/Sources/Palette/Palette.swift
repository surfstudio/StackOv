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
    public static var bluishwhite: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "Bluishwhite", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "Bluishwhite", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "Bluishwhite")!
        #endif
    }
    public static var darkDivider: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "DarkDivider", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "DarkDivider", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "DarkDivider")!
        #endif
    }
    public static var darkGray: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "DarkGray", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "DarkGray", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "DarkGray")!
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
    public static var lightBlack: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "LightBlack", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "LightBlack", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "LightBlack")!
        #endif
    }
    public static var lightDeepGray: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "LightDeepGray", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "LightDeepGray", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "LightDeepGray")!
        #endif
    }
    public static var lightDivider: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "LightDivider", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "LightDivider", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "LightDivider")!
        #endif
    }
    public static var lightGray: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "LightGray", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "LightGray", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "LightGray")!
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
    public static var paleSky: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "PaleSky", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "PaleSky", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "PaleSky")!
        #endif
    }
    public static var periwinkleCrayola: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "PeriwinkleCrayola", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "PeriwinkleCrayola", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "PeriwinkleCrayola")!
        #endif
    }
    public static var slateGray: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "SlateGray", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "SlateGray", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "SlateGray")!
        #endif
    }
    public static var slateGrayLight: CoreColor {
        #if !os(watchOS)
        let bundle: Bundle = .module
        #endif
        #if os(iOS) || os(tvOS)
        return CoreColor(named: "SlateGrayLight", in: bundle, compatibleWith: nil)!
        #elseif os(macOS)
        return CoreColor(named: "SlateGrayLight", bundle: bundle)!
        #elseif os(watchOS)
        return CoreColor(named: "SlateGrayLight")!
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
    public static var bluishwhite: Color { .init(PaletteCore.bluishwhite) }
    public static var darkDivider: Color { .init(PaletteCore.darkDivider) }
    public static var darkGray: Color { .init(PaletteCore.darkGray) }
    public static var dullGray: Color { .init(PaletteCore.dullGray) }
    public static var gainsboro: Color { .init(PaletteCore.gainsboro) }
    public static var grayblue: Color { .init(PaletteCore.grayblue) }
    public static var lightBlack: Color { .init(PaletteCore.lightBlack) }
    public static var lightDeepGray: Color { .init(PaletteCore.lightDeepGray) }
    public static var lightDivider: Color { .init(PaletteCore.lightDivider) }
    public static var lightGray: Color { .init(PaletteCore.lightGray) }
    public static var main: Color { .init(PaletteCore.main) }
    public static var paleSky: Color { .init(PaletteCore.paleSky) }
    public static var periwinkleCrayola: Color { .init(PaletteCore.periwinkleCrayola) }
    public static var slateGray: Color { .init(PaletteCore.slateGray) }
    public static var slateGrayLight: Color { .init(PaletteCore.slateGrayLight) }
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
