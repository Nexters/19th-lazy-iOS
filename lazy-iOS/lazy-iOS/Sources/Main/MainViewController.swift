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
    private let bubbleBehavior = BubbleBehaviorManager()

    private let bubbleView = UIView().then {
        $0.backgroundColor = .clear
    }

    private let drawerView = DrawerView()

    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        setView()
    }

    override func viewWillLayoutSubviews() {
        bubbleView.snp.updateConstraints { make in
            make.bottom.equalTo(drawerView.snp.top).offset(-20)
        }
    }

    // MARK: - Actions

    @objc
    func handleBubbleView(_ gesture: UIPanGestureRecognizer) {
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
            animator.updateItem(usingCurrentState: bubble)
        default:
            break
        }
    }

    // MARK: - Methods

    func setView() {
        view.backgroundColor = .black
        overrideUserInterfaceStyle = .dark

        animator.addBehavior(bubbleBehavior)

        for _ in 0 ... 10 {
            let size = CGFloat([50.0, 65.0, 80.0, 100.0].randomElement()!)

            let bubbleView = UIView(frame: CGRect(x: CGFloat.random(in: 10.0 ..< UIScreen.main.bounds.width), y: 0, width: size, height: size))
            bubbleView.cornerRound(radius: 20)
            bubbleView.backgroundColor = [UIColor.systemBlue, UIColor.systemPink, UIColor.systemOrange].randomElement()

            bubbleView.gestureRecognizers = [UIPanGestureRecognizer(target: self, action: #selector(handleBubbleView(_:)))]

            view.addSubview(bubbleView)
            bubbleBehavior.addBubble(bubbleView)
        }
    }

    func setConstraints() {
        view.addSubviews([bubbleView, drawerView])

        bubbleView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(drawerView.snp.top).offset(-20)
        }

        drawerView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }

    // MARK: - Protocols
}
