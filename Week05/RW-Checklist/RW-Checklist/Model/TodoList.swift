//
//  Data.swift
//  RW-Checklist
//
//  Created by Islombek Hasanov on 6/29/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import Foundation

class TodoList {
    var todos: [ChecklistItem] = []

    init() {
        todos.append(ChecklistItem("Take a job"))
        todos.append(ChecklistItem("Walk the dog"))
        todos.append(ChecklistItem("Call Baby"))
        todos.append(ChecklistItem("Kiss mom"))
        todos.append(ChecklistItem("be awesome"))
    }
}
