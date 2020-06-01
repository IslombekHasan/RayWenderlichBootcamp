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

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    var allLabels: [UILabel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews(for: UIScreen.main.bounds.size)
        getAllLabels()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateViews(for: size)
    }

    @IBAction func redSliderChanged(_ sender: UISlider) {
        changeBackgroundColor()
    }

    @IBAction func greenSliderChanged(_ sender: UISlider) {
        changeBackgroundColor()
    }

    @IBAction func blueSliderChanged(_ seÁnder: UISlider) {
        changeBackgroundColor()
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

    func changeBackgroundColor() {
        let red = redSlider.value.rounded() / 255
        let green = greenSlider.value.rounded() / 255
        let blue = blueSlider.value.rounded() / 255
        let color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1.0)
        self.view.backgroundColor = color
        changeFontColorFor(for: color)
    }

    func changeFontColorFor(for backgroundColor: UIColor) {
        // First we get luminance/brightness for the color following this algorhythm. https://stackoverflow.com/a/1855903/7403467
        let rgba = backgroundColor.rgba
        let luminance = (0.299 * rgba.red + 0.587 * rgba.green + 0.114 * rgba.blue)

        for label in allLabels {
            if luminance > 0.5 { // bright colors
                label.textColor = .black
            } else {
                label.textColor = .white
            }
        }
    }

    func getAllLabels() { // got too lazy to make outlets :(
        allLabels.append(headerStackView.viewWithTag(1) as! UILabel)
        allLabels.append(redStackView.viewWithTag(1) as! UILabel)
        allLabels.append(greenStackView.viewWithTag(1) as! UILabel)
        allLabels.append(blueStackView.viewWithTag(1) as! UILabel)
        allLabels.append(redStackView.viewWithTag(2) as! UILabel)
        allLabels.append(greenStackView.viewWithTag(2) as! UILabel)
        allLabels.append(blueStackView.viewWithTag(2) as! UILabel)
    }
}

