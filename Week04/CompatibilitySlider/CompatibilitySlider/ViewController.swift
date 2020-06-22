//
//  ViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Jay Strawn on 6/16/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

enum ButtonState: String {
    case start = "Let's start"
    case nextItem = "Next item"
    case nextPerson = "Switch to Person 2"
    case finish = "Calculate Compatibility"
}

class ViewController: UIViewController, ConfettiShowable {

    @IBOutlet weak var compatibilityItemLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    var compatibilityItems = ["Cats 😺", "Dogs 🐶", "Space 🌌", "Large Hadron Collider ⚛", "RW :]"] // Add more!
    var currentItemIndex: Int = 0 {
        didSet {
            if currentItemIndex == compatibilityItems.count - 1 {
                setButtonTitle(to: currentPerson == person1 ? .nextPerson : .finish)
            }

            if currentItemIndex > compatibilityItems.count - 1 {
                print("Hold your horses! You're going out of range...")
                currentItemIndex = oldValue
                return
            }
        }
    }

    var person1 = Person(id: 1, items: [:])
    var person2 = Person(id: 2, items: [:])
    var currentPerson: Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        reset()

        // testing confetti
        // let gr = UITapGestureRecognizer(target: self, action: #selector(displayConfetti))
        // view.addGestureRecognizer(gr)
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        print(sender.value)
    }

    @IBAction func didPressActionButton(_ sender: UIButton) {

        if sender.title(for: .normal) != ButtonState.start.rawValue {
            recordResult()
        }

        switch sender.title(for: .normal) {
        case ButtonState.start.rawValue:
            questionLabel.isHidden = false
            slider.isHidden = false
            setCurrentPerson(to: person1)

        case ButtonState.nextPerson.rawValue:
            setCurrentPerson(to: person2)

        case ButtonState.finish.rawValue:
            finishComparison()

        default:
            break
        }
    }

    func reset() {
        currentPerson = nil
        questionLabel.isHidden = true
        slider.isHidden = true
        setButtonTitle(to: .start)
        person1.items = [:]
        person2.items = [:]
        compatibilityItemLabel.text = "PikaMate"
    }

    func recordResult() {
        let currentItem = compatibilityItems[currentItemIndex]
        currentPerson?.items.updateValue(slider.value, forKey: currentItem)
        currentItemIndex += 1
        showComparisonItem()
    }

    func finishComparison() {
        let match = calculateCompatibility()
        let alert = UIAlertController(title: "Results", message: "You two are \(match)% compatible", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true) {
            self.reset()
        }
        if match > 85.0 {
            displayConfetti()
        }
    }

    func calculateCompatibility() -> Double {
        // If diff 0.0 is 100% and 5.0 is 0%, calculate match percentage
        var percentagesForAllItems: [Double] = []

        for (key, person1Rating) in person1.items {
            let person2Rating = person2.items[key] ?? 0
            let difference = abs(person1Rating - person2Rating) / 5.0
            percentagesForAllItems.append(Double(difference))
        }

        let sumOfAllPercentages = percentagesForAllItems.reduce(0, +)
        let matchPercentage = sumOfAllPercentages / Double(compatibilityItems.count)
        let matchString = 100 - (matchPercentage * 100).rounded()
        return matchString
    }

    var confettiTypes: [ConfettiType] = {
        let confettiColors = [
            (r: 149, g: 58, b: 255), (r: 255, g: 195, b: 41), (r: 255, g: 101, b: 26),
            (r: 123, g: 92, b: 255), (r: 76, g: 126, b: 255), (r: 71, g: 192, b: 255),
            (r: 255, g: 47, b: 39), (r: 255, g: 91, b: 134), (r: 233, g: 122, b: 208)
        ].map { UIColor(red: $0.r / 255.0, green: $0.g / 255.0, blue: $0.b / 255.0, alpha: 1) }

        // For each position x shape x color, construct an image
        return [ConfettiPosition.foreground, ConfettiPosition.background].flatMap { position in
            return [ConfettiShape.rectangle, ConfettiShape.circle].flatMap { shape in
                return confettiColors.map { color in
                    return ConfettiType(color: color, shape: shape, position: position)
                }
            }
        }
    }()

}

// changes UI State
extension ViewController {
    func setCurrentPerson(to person: Person) {
        currentItemIndex = 0
        currentPerson = person
        questionLabel.text = "Person \(currentPerson!.id), how do you feel about..."
        showComparisonItem()
        setButtonTitle(to: .nextItem)
    }

    func showComparisonItem() {
        compatibilityItemLabel.text = compatibilityItems[currentItemIndex]
    }

    func setButtonTitle(to state: ButtonState) {
        actionButton.setTitle(state.rawValue, for: .normal)
    }

}
