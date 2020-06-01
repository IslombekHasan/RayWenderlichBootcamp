//
//  Helpers.swift
//  ColorPikka
//
//  Created by Islombek Hasanov on 6/1/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import UIKit

extension UIColor {
    // this is from https://www.hackingwithswift.com/example-code/uicolor/how-to-read-the-red-green-blue-and-alpha-color-components-from-a-uicolor
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        return (red, green, blue, alpha)
    }
}
