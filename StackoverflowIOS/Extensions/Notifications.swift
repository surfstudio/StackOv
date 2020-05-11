//
//  Notifications.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 07/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation
import UIKit.UIResponder

extension Notification.Name {
    static let deviceWillTransition = Notification.Name("MainUIHostingController_viewWillTransition")
    static let keyboardWillShow = UIResponder.keyboardWillShowNotification
    static let keyboardWillHide = UIResponder.keyboardWillHideNotification
    static let keyboardDidHide = UIResponder.keyboardDidHideNotification
}
