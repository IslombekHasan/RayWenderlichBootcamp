//
//  ViewController.swift
//  Birdie
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        MediaPostsHandler.shared.getPosts()
        setUpTableView()
    }

    func setUpTableView() {
        // Set delegates, register custom cells, set up datasource, etc.
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib(nibName: textPostCell, bundle: nil), forCellReuseIdentifier: textPostCell)
        tableview.register(UINib(nibName: imagePostCell, bundle: nil), forCellReuseIdentifier: imagePostCell)
        tableview.reloadData()
    }

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        writePost(with: nil)
    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true)
    }

    func writePost(with image: UIImage?) {
        let alert = UIAlertController(title: "Chirp chirp", message: "Share your thoughts with the world :]", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Username"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Put your thoughts here"
        }

        let action = UIAlertAction(title: "Post", style: .default) { (action) in
            if let username = alert.textFields?[0].text, !username.isEmpty {
                let body = alert.textFields?[1].text
                var post: MediaPost
                if let image = image {
                    post = ImagePost(textBody: body, userName: username, timestamp: Date(), image: image)
                } else {
                    post = TextPost(textBody: body, userName: username, timestamp: Date())
                }
                MediaPostsHandler.shared.addPost(post: post)
                self.tableview.reloadData()
            } else {
                self.displayPostError("You must provide a username")
            }
        }

        alert.addAction(action)
        present(alert, animated: true)
    }

    func displayPostError(_ message: String = "") {
        let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MediaPostsHandler.shared.mediaPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = MediaPostsHandler.shared.mediaPosts[indexPath.row]
        let cell = MediaPostViewModel.shared.returnCell(for: post, in: tableView, for: indexPath)
        return cell
    }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dismiss(animated: true) {
                self.writePost(with: image)
            }
        }
    }
}
