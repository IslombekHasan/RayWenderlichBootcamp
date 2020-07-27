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

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!

    enum Status: String {
        case correct = "checkmark.circle.fill"
        case incorrect = "xmark.octagon.fill"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        containerView.layer.cornerRadius = 12
        containerView.setShadow()

        statusImageView.isHidden = true
        translatesAutoresizingMaskIntoConstraints = false

        let view = UIView()
        view.setShadow()
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.4
        view.backgroundColor = .white
        view.layer.cornerRadius = 12

        selectedBackgroundView = view
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setImage(to status: Status) {
        statusImageView.image = UIImage(systemName: status.rawValue)
        statusImageView.tintColor = status == .correct ? UIColor.systemGreen : UIColor.systemRed
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        selectedBackgroundView?.frame = containerView.frame
    }

}

extension UIView {
    func setShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 5
    }
}
