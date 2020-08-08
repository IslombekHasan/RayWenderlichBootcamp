//
//  Extensions.swift
//  Animachu
//
//  Created by Islombek Hasanov on 8/8/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundAndShadow() {
        round()
        shadow()
    }
    
    func round(radius: CGFloat = 12) {
        self.layer.cornerRadius = radius
    }
    
    func shadow(radius: CGFloat = 12) {
        self.layer.shadowRadius = radius
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
    }
}
