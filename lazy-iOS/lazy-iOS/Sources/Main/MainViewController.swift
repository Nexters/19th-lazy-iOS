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

    private lazy var animator = UIDynamicAnimator(referenceView: self.bubbleView)
    private let bubbleBehavior = BubbleBehavior()
    private let bubbleView = UIView().then {
        $0.backgroundColor = .black
    }

    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        setView()
    }

    // MARK: - Actions

    @objc
    func didTapView(_ gesture: UIPanGestureRecognizer) {
        guard let bubble = gesture.view else { return }

        switch gesture.state {
//        case .changed:
//            let translation = gesture.translation(in: bubbleView)
//            bubble.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
//
        case .ended:
            let velocity = gesture.velocity(in: bubbleView)
            let itemBehavior = UIDynamicItemBehavior(items: [bubble])
            itemBehavior.addLinearVelocity(velocity, for: bubble)

            animator.addBehavior(itemBehavior)
        default:
            break
        }
    }

    // MARK: - Methods

    func setView() {
        animator.addBehavior(bubbleBehavior)

        for _ in 0 ... 10 {
            let size = CGFloat([50.0, 65.0, 80.0, 100.0].randomElement()!)

            let bubbleView = UIView(frame: CGRect(x: 50, y: 100, width: size, height: size))
            bubbleView.cornerRounds()
            bubbleView.backgroundColor = [UIColor.systemBlue, UIColor.systemPink, UIColor.systemOrange].randomElement()

            bubbleView.gestureRecognizers = [UIPanGestureRecognizer(target: self, action: #selector(didTapView(_:)))]

            view.addSubview(bubbleView)
            bubbleBehavior.addBubble(bubbleView)
        }
    }

    func setConstraints() {
        view.addSubviews([bubbleView])

        bubbleView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(500)
        }
    }

    // MARK: - Protocols
}
