//
//  UIApplication.swift
//  StackOv
//
//  Created by Erik Basargin on 05/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import UIKit.UIApplication

extension UIApplication {
    func tryOpen(url: URL?, options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:], completionHandler completion: ((Bool) -> Void)? = nil) {
        guard let url = url else {
            completion?(false)
            return
        }
        if canOpenURL(url) {
            open(url, options: options, completionHandler: completion)
        }
    }
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
