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

    enum Status: String {
        case correct = "checkmark.circle.fill"
        case incorrect = "xmark.octagon.fill"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        statusImageView.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setImage(to status: Status) {
        statusImageView.image = UIImage(systemName: status.rawValue)
        statusImageView.tintColor = status == .correct ? UIColor.systemGreen : UIColor.systemRed
    }

}
