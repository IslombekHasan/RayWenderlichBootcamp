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

    private let names = ["new todo", "generic todo", "Fill me out", "i need something todo", "much todo about nothing"]

    init() {
        todos.append(ChecklistItem("Take a job"))
        todos.append(ChecklistItem("Walk the dog"))
        todos.append(ChecklistItem("Call Baby"))
        todos.append(ChecklistItem("Kiss mom"))
        todos.append(ChecklistItem("be awesome"))
    }

    func move(item: ChecklistItem, to index: Int) {
        guard let currentIndex = todos.firstIndex(of: item) else {
            return
        }
        todos.remove(at: currentIndex)
        todos.insert(item, at: index)
    }

    func remove(items: [ChecklistItem]) {
        for item in items {
            if let index = todos.firstIndex(of: item) {
                todos.remove(at: index)
            }
        }
    }

    func newTodo() -> ChecklistItem {
        let item = ChecklistItem(names.randomElement()!)
        todos.append(item)
        return item
    }
}
