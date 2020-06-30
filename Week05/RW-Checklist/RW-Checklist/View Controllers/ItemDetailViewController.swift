//
//  AddItemTableViewController.swift
//  RW-Checklist
//
//  Created by Islombek Hasanov on 6/29/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController {

    weak var delegate: ItemDetailViewControllerDelegate?
    weak var todoList: TodoList?
    weak var itemToEdit: ChecklistItem?

    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let item = itemToEdit {
            title = "Edit item"
            textField.text = item.text
            addBarButton.isEnabled = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }

    @IBAction func cancel(_ sender: Any) {
        delegate?.itemDetailViewControllerDidCancel(self)
    }

    @IBAction func done(_ sender: Any) {
        if let item = itemToEdit, let text = textField.text {
            item.text = text
            delegate?.itemDetailViewController(self, didFinishEditing: item)
        } else {
            if let item = todoList?.newTodo() {
                if let text = textField.text {
                    item.text = text
                }
                delegate?.itemDetailViewController(self, didFinishAdding: item)
            }
        }
    }
}

extension ItemDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text,
            let stringRange = Range(range, in: oldText) else {
                return false
        }

        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        addBarButton.isEnabled = !newText.isEmpty

        return true
    }
}
