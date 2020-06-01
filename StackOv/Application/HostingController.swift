//
//  HostingController.swift
//  StackOv
//
//  Created by Erik Basargin on 07/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

class HostingController<Content: View>: UIHostingController<Content> {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        NotificationCenter.default.post(name: .deviceWillTransition, object: nil, userInfo: ["size": size])
        super.viewWillTransition(to: size, with: coordinator)
    }
}
