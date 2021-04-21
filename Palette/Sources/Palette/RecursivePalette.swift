//
//  RecursivePalette.swift
//  StackOv (Palette module)
//
//  Created by Erik Basargin
//  Copyright © 2021 Erik Basargin. All rights reserved.
//

import struct SwiftUI.Color

public extension Palette {
    
    static var postBackgroundGradients: ContiguousArray<(Color, Color)> {
        [
            (Color(red: 0.438, green: 0.263, blue: 0.613).opacity(0.96), Color(red: 0.122, green: 0.192, blue: 0.438).opacity(0.96)),
            (Color(red: 0.271, green: 0.214, blue: 0.625).opacity(0.96), Color(red: 0.084, green: 0.206, blue: 0.45).opacity(0.96)),
            (Color(red: 0.115, green: 0.408, blue: 0.725).opacity(0.96), Color(red: 0.069, green: 0.221, blue: 0.504).opacity(0.96)),
            (Color(red: 0.121, green: 0.257, blue: 0.529).opacity(0.96), Color(red: 0.062, green: 0.167, blue: 0.375).opacity(0.96)),
            (Color(red: 0.228, green: 0.482, blue: 0.538).opacity(0.96), Color(red: 0.083, green: 0.207, blue: 0.321).opacity(0.96)),
            (Color(red: 0.113, green: 0.201, blue: 0.425).opacity(0.816), Color(red: 0.137, green: 0.285, blue: 0.45).opacity(0.96)),
            (Color(red: 0.102, green: 0.188, blue: 0.492).opacity(0.816), Color(red: 0.172, green: 0.137, blue: 0.387).opacity(0.96)),
            (Color(red: 0.127, green: 0.276, blue: 0.308).opacity(0.816), Color(red: 0.091, green: 0.222, blue: 0.317).opacity(0.96)),
            (Color(red: 0.298, green: 0.222, blue: 0.512).opacity(0.825), Color(red: 0.087, green: 0.127, blue: 0.338).opacity(0.96)),
            (Color(red: 0.216, green: 0.394, blue: 0.558).opacity(0.816), Color(red: 0.097, green: 0.139, blue: 0.225).opacity(0.96)),
            (Color(red: 0.181, green: 0.222, blue: 0.304).opacity(0.816), Color(red: 0.098, green: 0.143, blue: 0.233).opacity(0.96)),
            (Color(red: 0.189, green: 0.111, blue: 0.287).opacity(0.816), Color(red: 0.164, green: 0.145, blue: 0.375).opacity(0.96)),
            (Color(red: 0.146, green: 0.465, blue: 0.508).opacity(0.825), Color(red: 0.138, green: 0.131, blue: 0.45).opacity(0.96)),
            (Color(red: 0.408, green: 0.216, blue: 0.558).opacity(0.816), Color(red: 0.097, green: 0.148, blue: 0.225).opacity(0.96)),
            (Color(red: 0.148, green: 0.257, blue: 0.538).opacity(0.816), Color(red: 0.038, green: 0.236, blue: 0.279).opacity(0.96)),
            (Color(red: 0.111, green: 0.245, blue: 0.287).opacity(0.816), Color(red: 0.01, green: 0.176, blue: 0.213).opacity(0.96)),
            (Color(red: 0.214, green: 0.396, blue: 0.454).opacity(0.825), Color(red: 0.173, green: 0.105, blue: 0.204).opacity(0.96)),
            (Color(red: 0.216, green: 0.394, blue: 0.558).opacity(0.816), Color(red: 0.097, green: 0.139, blue: 0.225).opacity(0.96)),
            (Color(red: 0.172, green: 0.144, blue: 0.5).opacity(0.816), Color(red: 0.103, green: 0.179, blue: 0.45).opacity(0.96)),
            (Color(red: 0.184, green: 0.282, blue: 0.518).opacity(0.96), Color(red: 0.098, green: 0.216, blue: 0.439).opacity(0.96))
        ]
    }
}
