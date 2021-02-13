// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation
import SwiftUI
#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import class AppKit.NSImage
#else
import class UIKit.UIImage
#endif

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
public typealias ImageCore = NSImage
#else
public typealias ImageCore = UIImage
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Icons Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum IconsCore {

    public static var arrowLeft: ImageCore { ImageAsset(name: "arrow.left").image }
    public static var bellFill: ImageCore { ImageAsset(name: "bell.fill").image }
    public static var bell: ImageCore { ImageAsset(name: "bell").image }
    public static var bookmarkFill: ImageCore { ImageAsset(name: "bookmark.fill").image }
    public static var bookmark: ImageCore { ImageAsset(name: "bookmark").image }
    public static var checkmarkCircleFill: ImageCore { ImageAsset(name: "checkmark.circle.fill").image }
    public static var checkmark: ImageCore { ImageAsset(name: "checkmark").image }
    public static var crownCircleBronzeFill: ImageCore { ImageAsset(name: "crown.circle.bronze.fill").image }
    public static var crownCircleGoldFill: ImageCore { ImageAsset(name: "crown.circle.gold.fill").image }
    public static var crownCircleSilverFill: ImageCore { ImageAsset(name: "crown.circle.silver.fill").image }
    public static var eyeFill: ImageCore { ImageAsset(name: "eye.fill").image }
    public static var handThumbsdownFill: ImageCore { ImageAsset(name: "hand.thumbsdown.fill").image }
    public static var handThumbsupFill: ImageCore { ImageAsset(name: "hand.thumbsup.fill").image }
    public static var magnifyingglass: ImageCore { ImageAsset(name: "magnifyingglass").image }
    public static var paperclip: ImageCore { ImageAsset(name: "paperclip").image }
    public static var pencil: ImageCore { ImageAsset(name: "pencil").image }
    public static var person2Fill: ImageCore { ImageAsset(name: "person.2.fill").image }
    public static var planet: ImageCore { ImageAsset(name: "planet").image }
    public static var squareAndArrowUp: ImageCore { ImageAsset(name: "square.and.arrow.up").image }
    public static var starFill: ImageCore { ImageAsset(name: "star.fill").image }
    public static var star: ImageCore { ImageAsset(name: "star").image }
    public static var starRoundedFill: ImageCore { ImageAsset(name: "star.rounded.fill").image }
    public static var tagFill: ImageCore { ImageAsset(name: "tag.fill").image }
    public static var trayFill: ImageCore { ImageAsset(name: "tray.fill").image }
    public static var xmark: ImageCore { ImageAsset(name: "xmark").image }
    public static var xmarkRoundedBold: ImageCore { ImageAsset(name: "xmark.rounded.bold").image }
}

public enum Icons: String, CaseIterable {

    case arrowLeft
    case bellFill
    case bell
    case bookmarkFill
    case bookmark
    case checkmarkCircleFill
    case checkmark
    case crownCircleBronzeFill
    case crownCircleGoldFill
    case crownCircleSilverFill
    case eyeFill
    case handThumbsdownFill
    case handThumbsupFill
    case magnifyingglass
    case paperclip
    case pencil
    case person2Fill
    case planet
    case squareAndArrowUp
    case starFill
    case star
    case starRoundedFill
    case tagFill
    case trayFill
    case xmark
    case xmarkRoundedBold

    var image: Image {
        switch self {
            case .arrowLeft: return .init(icon: IconsCore.arrowLeft)
            case .bellFill: return .init(icon: IconsCore.bellFill)
            case .bell: return .init(icon: IconsCore.bell)
            case .bookmarkFill: return .init(icon: IconsCore.bookmarkFill)
            case .bookmark: return .init(icon: IconsCore.bookmark)
            case .checkmarkCircleFill: return .init(icon: IconsCore.checkmarkCircleFill)
            case .checkmark: return .init(icon: IconsCore.checkmark)
            case .crownCircleBronzeFill: return .init(icon: IconsCore.crownCircleBronzeFill)
            case .crownCircleGoldFill: return .init(icon: IconsCore.crownCircleGoldFill)
            case .crownCircleSilverFill: return .init(icon: IconsCore.crownCircleSilverFill)
            case .eyeFill: return .init(icon: IconsCore.eyeFill)
            case .handThumbsdownFill: return .init(icon: IconsCore.handThumbsdownFill)
            case .handThumbsupFill: return .init(icon: IconsCore.handThumbsupFill)
            case .magnifyingglass: return .init(icon: IconsCore.magnifyingglass)
            case .paperclip: return .init(icon: IconsCore.paperclip)
            case .pencil: return .init(icon: IconsCore.pencil)
            case .person2Fill: return .init(icon: IconsCore.person2Fill)
            case .planet: return .init(icon: IconsCore.planet)
            case .squareAndArrowUp: return .init(icon: IconsCore.squareAndArrowUp)
            case .starFill: return .init(icon: IconsCore.starFill)
            case .star: return .init(icon: IconsCore.star)
            case .starRoundedFill: return .init(icon: IconsCore.starRoundedFill)
            case .tagFill: return .init(icon: IconsCore.tagFill)
            case .trayFill: return .init(icon: IconsCore.trayFill)
            case .xmark: return .init(icon: IconsCore.xmark)
            case .xmarkRoundedBold: return .init(icon: IconsCore.xmarkRoundedBold)
        }
    }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

struct ImageAsset {

    fileprivate(set) var name: String

    var image: ImageCore {
        let bundle: Bundle = .module
        #if os(iOS) || os(tvOS)
        let image = ImageCore(named: name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
        let name = NSImage.Name(self.name)
        let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
        #elseif os(watchOS)
        let image = ImageCore(named: name)
        #endif
        guard let result = image else {
            fatalError("Unable to load image asset named \(name).")
        }
        return result
    }
}

// MARK: - Fileprivate extensions

fileprivate extension Image {

    init(icon: ImageCore) {
        #if canImport(AppKit) && !targetEnvironment(macCatalyst)
        self = Image(nsImage: icon)
        #else
        self = Image(uiImage: icon)
        #endif
    }
}

// MARK: - Extensions

public extension Image {

    /// Creates an icon image.
    ///
    /// This initializer creates an image using Icon package. To
    /// create an image, use `init(_:)` instead.
    ///
    /// - Parameters:
    ///   - icon: The icon image.
    init(_ icon: Icons) {
        self = icon.image
    }
}

public extension Label where Title == Text, Icon == Image {

    /// Creates a label with an icon image and a title generated from a
    /// localized string.
    ///
    /// - Parameters:
    ///    - titleKey: A title generated from a localized string.
    ///    - image: The name of the image resource to lookup.
    init(_ titleKey: LocalizedStringKey, icon: Icons) {
        self = Label(title: { Text(titleKey) }, icon: { icon.image })
    }

    /// Creates a label with an icon image and a title generated from a string.
    ///
    /// - Parameters:
    ///    - title: A string to used as the label's title.
    ///    - icon: The icon resource to lookup.
    init<S: StringProtocol>(_ title: S, icon: Icons) {
        self = Label(title: { Text(title) }, icon: { icon.image })
    }
}
