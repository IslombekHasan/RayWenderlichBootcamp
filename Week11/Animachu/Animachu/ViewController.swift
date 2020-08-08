//
//  ViewController.swift
//  Animachu
//
//  Created by Islombek Hasanov on 8/6/20.
//  Copyright © 2020 Islombek Khasanov. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var controlsContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var dayNightButton: UIButton!
    @IBOutlet weak var moveButton: UIButton!
    @IBOutlet weak var playButton: UIButton!

    @IBOutlet weak var moveButtonLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorButtonTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var dayNightButtonBottomConstraint: NSLayoutConstraint!

    var controlsOpen: Bool = false
//    {
//        didSet {
//            if areControlsVisible { showControls() }
//            else { hideControls() }
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        animateControls()
        setupView()
        setupAnimation()
        setupButtons()
    }

    @IBAction func toggleControlsAndAnimate() {
        controlsOpen.toggle()
        animateControls()
    }

    @IBAction func addDayNightAnimation(_ sender: Any) {
        ReactionView.showReaction(in: view, from: .top, with: "Day/Night animation added")
    }
    
    @IBAction func addColorAnimation(_ sender: Any) {
        ReactionView.showReaction(in: view, with: "Color animation added")
    }
    
    @IBAction func addMoveAnimation(_ sender: Any) {
        ReactionView.showReaction(in: view, from: .top, with: "Move animation added")
    }
    
    func animateControls() {
        dayNightButtonBottomConstraint.constant = controlsOpen ? 50 : -45
        moveButtonLeadingConstraint.constant = controlsOpen ? 50 : -45
        colorButtonTrailingConstraint.constant = controlsOpen ? 50 : -45

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.2, animations: {

            self.colorButton.alpha = self.controlsOpen ? 1 : 0
            self.moveButton.alpha = self.controlsOpen ? 1 : 0
            self.dayNightButton.alpha = self.controlsOpen ? 1 : 0

            self.view.layoutIfNeeded()
        })
    }

    func setupView() {
        let gradient: CAGradientLayer = CAGradientLayer()

        gradient.colors = [UIColor(red: 0.894, green: 0.325, blue: 0.000, alpha: 1.000).cgColor, UIColor(red: 0.984, green: 0.733, blue: 0.000, alpha: 1.000).cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)

        self.view.layer.insertSublayer(gradient, at: 0)
    }

    func setupAnimation() {
        titleLabel.alpha = 0
        controlsContainerView.alpha = 0
        animationView.animation = Animation.named("sunrise-animation")
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFill

        animationView.play(fromProgress: 0.0, toProgress: 0.5, loopMode: .playOnce) { (finished) in

            UIView.animate(withDuration: 0.5) {
                self.titleLabel.alpha = 1
            }

            self.animationView.play(fromProgress: 0.5, toProgress: 1.0, loopMode: .playOnce) { (finished) in

                UIView.animate(withDuration: 0.7, animations: {
                    self.controlsContainerView.alpha = 1
                    self.titleLabel.alpha = 0
                }) { _ in
                    self.toggleControlsAndAnimate()
                }
            }
        }
    }
    
    func setupButtons() {
        playButton.roundAndShadow()
        dayNightButton.roundAndShadow()
        moveButton.roundAndShadow()
        colorButton.roundAndShadow()
    }

}

