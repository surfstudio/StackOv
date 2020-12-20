//
//  RecursivePalette.swift
//  This source file is part of the StackOv open source project
//

import struct SwiftUI.Color

public extension Palette {
    
    static var linearGradientPalette: ContiguousArray<(Color, Color)> {
        [(Color(red: 0.471, green: 0.238, blue: 0.704),
          Color(red: 0.276, green: 0.122, blue: 0.438)),
         (Color(red: 0.348, green: 0.222, blue: 0.762),
          Color(red: 0.181, green: 0.119, blue: 0.375)),
         (Color(red: 0.115, green: 0.408, blue: 0.725),
          Color(red: 0.069, green: 0.221, blue: 0.504)),
         (Color(red: 0.121, green: 0.257, blue: 0.529),
          Color(red: 0.062, green: 0.167, blue: 0.375)),
         (Color(red: 0.264, green: 0.55, blue: 0.43),
          Color(red: 0.083, green: 0.321, blue: 0.221)),
         (Color(red: 0.113, green: 0.425, blue: 0.406).opacity(0.85),
          Color(red: 0.053, green: 0.325, blue: 0.309)),
         (Color(red: 0.479, green: 0.14, blue: 0.282).opacity(0.85),
          Color(red: 0.387, green: 0.137, blue: 0.377)),
         (Color(red: 0.127, green: 0.276, blue: 0.308).opacity(0.85),
          Color(red: 0.091, green: 0.222, blue: 0.317)),
         (Color(red: 0.517, green: 0.324, blue: 0.282).opacity(0.86),
          Color(red: 0.254, green: 0.166, blue: 0.116)),
         (Color(red: 0.216, green: 0.394, blue: 0.558).opacity(0.85),
          Color(red: 0.097, green: 0.139, blue: 0.225)),
         (Color(red: 0.181, green: 0.222, blue: 0.304).opacity(0.85),
          Color(red: 0.098, green: 0.143, blue: 0.233)),
         (Color(red: 0.188, green: 0.110, blue: 0.286).opacity(0.81),
          Color(red: 0.165, green: 0.145, blue: 0.337).opacity(0.95))]
    }
}
