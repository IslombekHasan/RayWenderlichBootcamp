//
//  Data.swift
//  RW-Checklist
//
//  Created by Islombek Hasanov on 6/29/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import Foundation

class TodoList {

    enum Priority: Int, CaseIterable {
        case high, medium, low, no
    }

    private var highPriorityTodos: [ChecklistItem] = []
    private var mediumPriorityTodos: [ChecklistItem] = []
    private var lowPriorityTodos: [ChecklistItem] = []
    private var noPriorityTodos: [ChecklistItem] = []

    private let names = ["new todo", "generic todo", "Fill me out", "i need something todo", "much todo about nothing"]

    init() {
        addTodo(ChecklistItem("Take a job"), for: .medium)
        addTodo(ChecklistItem("Walk the dog"), for: .medium)
        addTodo(ChecklistItem("Call Baby"), for: .medium)
        addTodo(ChecklistItem("Kiss mom"), for: .medium)
        addTodo(ChecklistItem("be awesome"), for: .medium)
    }

    func todoList(for priority: Priority) -> [ChecklistItem] {
        switch priority {
        case .high:
            return highPriorityTodos
        case .medium:
            return mediumPriorityTodos
        case .low:
            return lowPriorityTodos
        case .no:
            return noPriorityTodos
        }
    }

    func addTodo(_ item: ChecklistItem, for priority: Priority, at index: Int = -1) {
        if (index < 0) {
            switch priority {
            case .high:
                highPriorityTodos.append(item)
            case .medium:
                mediumPriorityTodos.append(item)
            case .low:
                lowPriorityTodos.append(item)
            case .no:
                noPriorityTodos.append(item)
            }
        } else {
            switch priority {
            case .high:
                highPriorityTodos.insert(item, at: index)
            case .medium:
                mediumPriorityTodos.insert(item, at: index)
            case .low:
                lowPriorityTodos.insert(item, at: index)
            case .no:
                noPriorityTodos.insert(item, at: index)
            }
        }
    }

    func newTodo() -> ChecklistItem {
        let item = ChecklistItem(names.randomElement()!)
        mediumPriorityTodos.append(item)
        return item
    }

    func move(item: ChecklistItem, from sourcePriority: Priority, at sourceIndex: Int, to destinationPriority: Priority, at destinationIndex: Int) {
        remove(item, from: sourcePriority, at: sourceIndex)
        addTodo(item, for: destinationPriority, at: destinationIndex)
    }

    func remove(_ item: ChecklistItem, from priority: Priority, at index: Int) {
        switch priority {
        case .high:
            highPriorityTodos.remove(at: index)
        case .medium:
            mediumPriorityTodos.remove(at: index)
        case .low:
            lowPriorityTodos.remove(at: index)
        case .no:
            noPriorityTodos.remove(at: index)
        }
    }

//    func remove(items: [ChecklistItem]) {
//        for item in items {
//            if let index = todos.firstIndex(of: item) {
//                todos.remove(at: index)
//            }
//        }
//    }

}
