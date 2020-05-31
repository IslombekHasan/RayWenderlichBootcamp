//
//  ViewController.swift
//  ColorPikka
//
//  Created by Islombek Hasanov on 5/31/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var redStackView: UIStackView!
    @IBOutlet weak var greenStackView: UIStackView!
    @IBOutlet weak var blueStackView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews(for: UIScreen.main.bounds.size)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateViews(for: size)

    }

    func updateViews(for size: CGSize) {
        let isLandscape = size.width > size.height
        if isLandscape {
            updateViewsForLandscape()
        } else {
            updateViewsForPortrait()
        }
    }

    func updateViewsForLandscape() {
        headerStackView.axis = .horizontal
        redStackView.spacing = 2
        greenStackView.spacing = 2
        blueStackView.spacing = 2

    }

    func updateViewsForPortrait() {
        headerStackView.axis = .vertical
        redStackView.spacing = 8
        greenStackView.spacing = 8
        blueStackView.spacing = 8
    }

}

