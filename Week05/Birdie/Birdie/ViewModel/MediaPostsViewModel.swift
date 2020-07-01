//
//  MediaPostsViewModel.swift
//  Birdie
//
//  Created by Islombek Hasanov on 7/1/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

let textPostCell = "TextPostCell"
let imagePostCell = "ImagePostCell"

class MediaPostViewModel {

    let dateFormatter = DateFormatter()

    static let shared = MediaPostViewModel()

    private init() {
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
    }

    func returnCell(for post: MediaPost, in tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        if let post = post as? TextPost {
            let cell = tableView.dequeueReusableCell(withIdentifier: textPostCell, for: indexPath) as! TextPostCell
            cell.usernameLabel.text = post.userName
            cell.postTextLabel.text = post.textBody
            cell.timestampLabel.text = dateFormatter.string(from: post.timestamp)
            return cell
        } else if let post = post as? ImagePost {
            let cell = tableView.dequeueReusableCell(withIdentifier: imagePostCell, for: indexPath) as! ImagePostCell
            cell.usernameLabel.text = post.userName
            cell.postTextLabel.text = post.textBody
            cell.postImageView.image = post.image
            cell.timestampLabel.text = dateFormatter.string(from: post.timestamp)
            return cell
        } else {
            fatalError("What type of MediaPost is this?")
        }
    }

}
