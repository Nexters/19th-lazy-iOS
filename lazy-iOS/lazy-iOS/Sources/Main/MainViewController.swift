//
//  ViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/10.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - UIComponenets

    // MARK: - Properties

    private lazy var animator = UIDynamicAnimator(referenceView: self.view)
    private let bubbleBehavior = BubbleBehavior()

    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        animator.addBehavior(bubbleBehavior)
    }

    override func viewDidAppear(_ animated: Bool) {
        setView()
    }

    // MARK: - Actions

    // MARK: - Methods

    func setView() {
        for _ in 0 ... 30 {
            let size = CGFloat([50.0, 65.0, 80.0, 100.0].randomElement()!)

            let bubbleView = UIView(frame: CGRect(x: 50, y: 100, width: size, height: size))
            bubbleView.cornerRounds()
            bubbleView.backgroundColor = [UIColor.systemBlue, UIColor.systemPink, UIColor.systemOrange].randomElement()

            view.addSubview(bubbleView)
            bubbleBehavior.addBubble(bubbleView)
        }
    }

    // MARK: - Protocols
}
