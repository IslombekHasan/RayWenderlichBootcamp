//
//  ViewController.swift
//  ColorPikka
//
//  Created by Islombek Hasanov on 5/31/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var modeControl: UISegmentedControl!

    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var slidersContainer: UIView!
    @IBOutlet weak var redStackView: UIStackView!
    @IBOutlet weak var greenStackView: UIStackView!
    @IBOutlet weak var blueStackView: UIStackView!

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    @IBOutlet weak var currentRedValueLabel: UILabel!
    @IBOutlet weak var currentGreenValueLabel: UILabel!
    @IBOutlet weak var currentBlueValueLabel: UILabel!

    var allLabels: [UILabel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        slidersContainer.layer.cornerRadius = 8
        updateViews(for: UIScreen.main.bounds.size)
        setAllLabels()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateViews(for: size)
    }

    @IBAction func modeChanged(_ sender: UISegmentedControl) {

        if sender.selectedSegmentIndex == 0 {
            setUpForRGB()
        } else {
            setUpForHSB()
        }

        changeBackgroundColor()
    }

    @IBAction func redSliderChanged() {
        currentRedValueLabel.text = String(Int(redSlider.value.rounded()))
        changeBackgroundColor()
    }

    @IBAction func greenSliderChanged() {
        currentGreenValueLabel.text = String(Int(greenSlider.value.rounded()))
        changeBackgroundColor()
    }

    @IBAction func blueSliderChanged() {
        currentBlueValueLabel.text = String(Int(blueSlider.value.rounded()))
        changeBackgroundColor()
    }

    @IBAction func didSetColor(_ sender: Any) {

        let alert = UIAlertController(title: "Set color", message: "Give your color a cute name and see the magic happen! ✨", preferredStyle: .alert)
        let abracadabra = UIAlertAction(title: "Abracadabra!", style: .default, handler: {
            action in
            let colorTitle = alert.textFields![0].text
            self.headerLabel.text = colorTitle!.isEmpty ? "ColorPikka!" : colorTitle
            self.changeBackgroundColor(forAll: true)
        })

        alert.addAction(abracadabra)
        alert.addTextField(configurationHandler: nil)

        present(alert, animated: true)
    }

    @IBAction func reset(_ sender: Any) {
        redSlider.setValue(0, animated: true)
        greenSlider.setValue(0, animated: true)
        blueSlider.setValue(0, animated: true)

        UIView.animate(withDuration: 0.5, animations: {
            self.view.backgroundColor = UIColor.systemYellow
            self.slidersContainer.backgroundColor = UIColor.clear
        })
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
        headerLabel.textAlignment = .left
        redStackView.spacing = 2
        greenStackView.spacing = 2
        blueStackView.spacing = 2
    }

    func updateViewsForPortrait() {
        headerStackView.axis = .vertical
        headerLabel.textAlignment = .center
        redStackView.spacing = 8
        greenStackView.spacing = 8
        blueStackView.spacing = 8
    }

    func changeBackgroundColor(forAll: Bool = false) {
        var color: UIColor

        if modeControl.selectedSegmentIndex == 0 {
            let red = CGFloat(redSlider.value.rounded() / 255)
            let green = CGFloat(greenSlider.value.rounded() / 255)
            let blue = CGFloat(blueSlider.value.rounded() / 255)
            color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        } else {
            let hue = CGFloat(redSlider.value.rounded() / 360)
            let saturation = CGFloat(greenSlider.value.rounded() / 100)
            let brigthness = CGFloat(blueSlider.value.rounded() / 100)
            color = UIColor(hue: hue, saturation: saturation, brightness: brigthness, alpha: 1.0)
        }

        changeFontColor(basedOn: color, forAll: forAll)
        slidersContainer.backgroundColor = color
        if forAll {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.backgroundColor = color
            })
        }
    }

    func changeFontColor(basedOn backgroundColor: UIColor, forAll: Bool = true) {
        // First we get luminance/brightness for the color following this algorhythm. https://stackoverflow.com/a/1855903/7403467
        let rgba = backgroundColor.rgba
        let luminance = (0.299 * rgba.red + 0.587 * rgba.green + 0.114 * rgba.blue)

        // then set font colors based on that value
        for label in allLabels {
            if !forAll && label == headerLabel { continue }

            if luminance > 0.5 { // bright colors
                label.textColor = .black
            } else {
                label.textColor = .white
            }
        }
    }

    func setUpForRGB() {
        redSlider.maximumValue = 255
        greenSlider.maximumValue = 255
        blueSlider.maximumValue = 255
        redLabel.text = "Red"
        greenLabel.text = "Green"
        blueLabel.text = "Blue"
        redSliderChanged()
        greenSliderChanged()
        blueSliderChanged()
    }

    func setUpForHSB() {
        redSlider.maximumValue = 360
        greenSlider.maximumValue = 100
        blueSlider.maximumValue = 100
        redLabel.text = "Hue"
        greenLabel.text = "Saturation"
        blueLabel.text = "Brightness"
        redSliderChanged()
        greenSliderChanged()
        blueSliderChanged()
    }

    func setAllLabels() {
        allLabels.append(headerLabel)
        allLabels.append(redLabel)
        allLabels.append(greenLabel)
        allLabels.append(blueLabel)
        allLabels.append(currentRedValueLabel)
        allLabels.append(currentGreenValueLabel)
        allLabels.append(currentBlueValueLabel)
    }
}

