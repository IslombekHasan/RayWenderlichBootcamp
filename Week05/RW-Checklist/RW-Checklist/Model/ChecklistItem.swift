//
//  ChecklistItem.swift
//  RW-Checklist
//
//  Created by Islombek Hasanov on 6/29/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
    
    init(_ text: String) {
        self.text = text
    }
}
