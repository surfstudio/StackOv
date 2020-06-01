//
//  Int.swift
//  StackoverflowIOS
//
//  Created by Erik Basargin on 31/05/2020.
//  Copyright © 2020 Ephedra Software. All rights reserved.
//

import Foundation

extension Int {
    var short: String {
        let number = Double(self)
        let thousandNum = number / 1000
        let millionNum = number / 1000000
        if number >= 1000 && number < 1000000 {
            return floor(thousandNum) == thousandNum ? "\(Int(thousandNum))k" : "\(thousandNum.roundToPlaces(places: 1))k"
        }
        if number > 1000000 {
            return floor(millionNum) == millionNum ? "\(Int(thousandNum))k" : "\(millionNum.roundToPlaces(places: 1))M"
        } else {
            return floor(number) == number ? "\(Int(number))" : "\(number)"
        }
    }
}

extension Double {
    func roundToPlaces(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        var value = self * divisor
        value.round()
        return value / divisor
    }
}
