//
//  UIEdgeInsets.swift
//  StackOv
//
//  Created by Erik Basargin on 02/06/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import SwiftUI

extension UIEdgeInsets {
    var toEdgeInsets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
