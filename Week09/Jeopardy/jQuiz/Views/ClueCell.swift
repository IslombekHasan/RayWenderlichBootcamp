//
//  ClueCell.swift
//  jQuiz
//
//  Created by Islombek Hasanov on 7/27/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import UIKit

class ClueCell: UITableViewCell {

    static let reuseIdentifier = String(describing: ClueCell.self)
    
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
