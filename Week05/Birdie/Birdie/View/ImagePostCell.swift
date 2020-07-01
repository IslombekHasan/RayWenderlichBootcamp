//
//  ImagePostTableViewCell.swift
//  Birdie
//
//  Created by Islombek Hasanov on 7/1/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ImagePostCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
