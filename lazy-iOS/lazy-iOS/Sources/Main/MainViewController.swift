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
    private lazy var gravityBehavior = UIGravityBehavior(items: [])
    private lazy var collisionBehavior = UICollisionBehavior(items: []).then {
        $0.addBoundary(
            withIdentifier: "bottom-wall" as NSCopying,
            for: .init(rect: CGRect(origin: CGPoint(x: 0, y: UIScreen.main.bounds.height - 1), size: CGSize(width: UIScreen.main.bounds.width, height: 1)))
        )

        $0.addBoundary(
            withIdentifier: "left-wall" as NSCopying,
            for: .init(rect: CGRect(origin: .zero, size: CGSize(width: 1, height: UIScreen.main.bounds.height)))
        )

        $0.addBoundary(
            withIdentifier: "right-wall" as NSCopying,
            for: .init(rect: CGRect(origin: CGPoint(x: UIScreen.main.bounds.width - 1, y: 0),
                                    size: CGSize(width: 1, height: UIScreen.main.bounds.height))
            )
        )
    }

    private lazy var dynamicItemBehavior = UIDynamicItemBehavior(items: []).then {
        $0.friction = 0.5
        $0.elasticity = 0
    }

    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        setView()
    }

    // MARK: - Actions

    // MARK: - Methods

    func setView() {
        for _ in 0 ... 30 {
            let size = CGFloat([50.0, 65.0, 80.0, 100.0].randomElement()!)

            let bubbleView = UIView(frame: CGRect(x: 50, y: -100, width: size, height: size))
            bubbleView.cornerRounds()
            bubbleView.backgroundColor = [UIColor.systemBlue, UIColor.systemPink, UIColor.systemOrange].randomElement()

            view.addSubview(bubbleView)

            gravityBehavior.addItem(bubbleView)
            collisionBehavior.addItem(bubbleView)
            dynamicItemBehavior.addItem(bubbleView)
        }

        animator.addBehavior(gravityBehavior)
        animator.addBehavior(collisionBehavior)
        animator.addBehavior(dynamicItemBehavior)
    }

    // MARK: - Protocols
}
