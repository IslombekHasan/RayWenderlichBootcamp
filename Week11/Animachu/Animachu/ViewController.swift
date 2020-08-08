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

    enum AnimationTypes {
        case dayNight
        case color
        case move
    }

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var controlsContainerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var colorButton: UIButton!
    @IBOutlet weak var dayNightButton: UIButton!
    @IBOutlet weak var moveButton: UIButton!
    @IBOutlet weak var playButton: UIButton!

    @IBOutlet weak var titleCenterXContraint: NSLayoutConstraint!
    @IBOutlet weak var moveButtonLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var colorButtonTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var dayNightButtonBottomConstraint: NSLayoutConstraint!

    var animations: [AnimationTypes] = []
    var pp = UIViewPropertyAnimator(duration: 2.0, curve: .linear)

    var controlsOpen: Bool = false
    var toDaylight: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        animateControls()
        setupView()
        setupLottieAnimation()
        setupButtons()
    }

    @IBAction func toggleControlsAndAnimate() {
        controlsOpen.toggle()
        animateControls()

        playButton.setImage(UIImage(systemName: controlsOpen ? "play" : "plus"), for: .normal)

        if !controlsOpen {
            DispatchQueue.main.async {
                self.pp.startAnimation()
            }
        }
    }

    @IBAction func addDayNightAnimation(_ sender: Any) {
        animations.append(.dayNight)
        toDaylight.toggle()
        ReactionView.showReaction(in: view, from: .top, with: "\(toDaylight ? "Daylight" : "Nightlife") animation added")
        dayNightButton.setImage(UIImage(systemName: toDaylight ? "moon.stars" : "sunrise"), for: .normal)

        pp.stopAnimation(true)
        pp.addAnimations {
            self.toDaylight ? self.animateToDaylight() : self.animateToNight()
        }
    }

    @IBAction func addColorAnimation(_ sender: Any) {
        animations.append(.color)
        ReactionView.showReaction(in: view, with: "Color animation added")
        pp.stopAnimation(true)
        pp.addAnimations {
            let color = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
            self.playButton.backgroundColor = color
            self.colorButton.backgroundColor = color
            self.moveButton.backgroundColor = color
            self.dayNightButton.backgroundColor = color
        }
    }

    @IBAction func addMoveAnimation(_ sender: Any) {
        animations.append(.move)
        ReactionView.showReaction(in: view, from: .top, with: "Move animation added")

        pp.stopAnimation(true)
        pp.addAnimations {
            let scale = CGFloat.random(in: 1...3)
            let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
            let rotationTransform = CGAffineTransform(rotationAngle: CGFloat.pi)
            
            self.animationView.transform = [scaleTransform, rotationTransform].randomElement()!
            self.playButton.frame.origin.y = CGFloat.random(in: 0...UIScreen.main.bounds.height - 50)
            self.playButton.frame.origin.x = CGFloat.random(in: 0...UIScreen.main.bounds.width - 50)
        }
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

    func setupLottieAnimation() {
        titleLabel.alpha = 0
        titleCenterXContraint.constant = 50
        view.layoutIfNeeded()

        controlsContainerView.alpha = 0
        animationView.animation = Animation.named("sunrise-animation")
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFill

        animationView.play(fromProgress: 0.0, toProgress: 0.5, loopMode: .playOnce) { (finished) in

            self.titleCenterXContraint.constant = 0

            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
                self.titleLabel.alpha = 1
                self.view.layoutIfNeeded()
            })

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

    func animateToDaylight() {
        DispatchQueue.main.async {
            self.animationView.play(fromProgress: 0.0,
                               toProgress: 1.0)
        }
    }

    func animateToNight() {
        DispatchQueue.main.async {
            self.animationView.play(fromProgress: 1.0,
                               toProgress: 0.0)
        }
    }
}

