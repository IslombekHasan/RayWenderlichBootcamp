//
//  ViewController.swift
//  RW-Checklist
//
//  Created by Islombek Hasanov on 6/24/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var todoList: TodoList

    required init?(coder: NSCoder) {
        todoList = TodoList()
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addItem(_ sender: Any) {
        let newIndex = todoList.todos.count
        _ = todoList.newTodo()
        let indexPath = IndexPath(row: newIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let itemDetailViewController = segue.destination as? ItemDetailViewController {
                itemDetailViewController.delegate = self
                itemDetailViewController.todoList = todoList
            }
        } else if segue.identifier == "EditItemSegue" {
            if let itemDetailViewController = segue.destination as? ItemDetailViewController {
                if let cell = sender as? UITableViewCell,
                    let indexPath = tableView.indexPath(for: cell) {
                    let item = todoList.todos[indexPath.row]
                    itemDetailViewController.itemToEdit = item
                    itemDetailViewController.delegate = self
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        todoList.todos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = todoList.todos[indexPath.row]
        configureText(cell: cell, with: item)
        configureCheckmark(cell: cell, with: item)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = todoList.todos[indexPath.row]
            item.toggleChecked()
            configureCheckmark(cell: cell, with: item)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        todoList.todos.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }

    func configureText(cell: UITableViewCell, with item: ChecklistItem) {
        if let label = cell.viewWithTag(1000) as? UILabel {
            label.text = item.text
        }
    }

    func configureCheckmark(cell: UITableViewCell, with item: ChecklistItem) {
        guard let checkmark = cell.viewWithTag(1001) as? UILabel else {
            return
        }
        checkmark.isHidden = !item.checked
    }
}

extension ChecklistViewController: ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }

    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
        let rowIndex = todoList.todos.count - 1
        let indexPath = IndexPath(row: rowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        navigationController?.popViewController(animated: true)
        if let index = todoList.todos.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(cell: cell, with: item)
            }
        }
    }
}
