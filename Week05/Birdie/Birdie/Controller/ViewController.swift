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
        setUpTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        MediaPostsHandler.shared.getPosts()
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
    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {
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
