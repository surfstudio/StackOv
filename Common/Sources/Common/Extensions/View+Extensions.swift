//
//  View+Extensions.swift
//  StackOv (Common module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import UIKit.UIDevice
import SwiftUI

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension View {

    /// Populates the toolbar or navigation bar of the phone with items
    /// whose content is the specified views.
    ///
    /// - Parameter content: The views representing the content of the toolbar.
    @ViewBuilder
    func phoneToolbar<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        if UIDevice.current.userInterfaceIdiom.isPhone {
            self.toolbar(content: content)
        } else {
            self
        }
    }
    
    /// Populates the toolbar or navigation bar of the phone with the specified items.
    ///
    /// - Parameter items: The items representing the content of the toolbar.
    @ViewBuilder
    func phoneToolbar<Content: ToolbarContent>(@ToolbarContentBuilder content: () -> Content) -> some View {
        if UIDevice.current.userInterfaceIdiom.isPhone {
            self.toolbar(content: content)
        } else {
            self
        }
    }


    /// Populates the toolbar or navigation bar of the phone with the specified items,
    /// allowing for user customization.
    ///
    /// - Parameters:
    ///   - id: A unique identifier for this toolbar.
    ///   - content: The content representing the content of the toolbar.
    @ViewBuilder
    func phoneToolbar<Content: CustomizableToolbarContent>(id: String, @ToolbarContentBuilder content: () -> Content) -> some View {
        if UIDevice.current.userInterfaceIdiom.isPhone {
            self.toolbar(id: id, content: content)
        } else {
            self
        }
    }
    
    /// Populates the toolbar or navigation bar of the pad with items
    /// whose content is the specified views.
    ///
    /// - Parameter content: The views representing the content of the toolbar.
    @ViewBuilder
    func padToolbar<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        if UIDevice.current.userInterfaceIdiom.isPad {
            self.toolbar(content: content)
        } else {
            self
        }
    }
    
    /// Populates the toolbar or navigation bar of the pad with the specified items.
    ///
    /// - Parameter items: The items representing the content of the toolbar.
    @ViewBuilder
    func padToolbar<Content: ToolbarContent>(@ToolbarContentBuilder content: () -> Content) -> some View {
        if UIDevice.current.userInterfaceIdiom.isPad {
            self.toolbar(content: content)
        } else {
            self
        }
    }


    /// Populates the toolbar or navigation bar of the pad with the specified items,
    /// allowing for user customization.
    ///
    /// - Parameters:
    ///   - id: A unique identifier for this toolbar.
    ///   - content: The content representing the content of the toolbar.
    @ViewBuilder
    func padToolbar<Content: CustomizableToolbarContent>(id: String, @ToolbarContentBuilder content: () -> Content) -> some View {
        if UIDevice.current.userInterfaceIdiom.isPad {
            self.toolbar(id: id, content: content)
        } else {
            self
        }
    }
    
    /// Applies a pointer hover effect to the view.
    ///
    /// > Note: The system may fall back to a more appropriate effect.
    @available(macOS, unavailable)
    @available(tvOS, unavailable)
    @available(watchOS, unavailable)
    @ViewBuilder
    func padHoverEffect(_ effect: HoverEffect = .automatic) -> some View {
        if UIDevice.current.userInterfaceIdiom.isPad {
            self.hoverEffect(effect)
        } else {
            self
        }
    }
}
