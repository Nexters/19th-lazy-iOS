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

        setView()
        setConstraints()
        setDelegate()
    }

    override func viewWillAppear(_ animated: Bool) {
        bubbleBehavior.collisionBehavior.collisionDelegate = bubbleBehavior
        bubbleBehavior.updateBubblePosition()
    }

    override func viewDidDisappear(_ animated: Bool) {
        bubbleBehavior.collisionBehavior.collisionDelegate = nil
        bubbleBehavior.stopBubble()
    }

    override func viewWillLayoutSubviews() {
        bubbleView.snp.updateConstraints { make in
            make.bottom.equalTo(drawerView.snp.top).offset(1)
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

        for idx in 0 ... 6 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(idx * 200)) {
                let bubbleView = UIView(frame: CGRect(x: CGFloat.random(in: 100.0 ..< UIScreen.main.bounds.width - 100), y: 0, width: 120, height: 120))
                bubbleView.cornerRounds()
                bubbleView.backgroundColor = [UIColor.systemBlue, UIColor.systemPink, UIColor.systemOrange].randomElement()

                bubbleView.gestureRecognizers = [UIPanGestureRecognizer(target: self, action: #selector(self.handleBubbleView(_:)))]

                self.view.addSubview(bubbleView)
                self.bubbleBehavior.addBubble(bubbleView)
            }
        }
    }

    func setConstraints() {
        view.addSubviews([bubbleView, drawerView])

        bubbleView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(drawerView.snp.top).offset(1)
        }

        drawerView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(UIComponentsConstants.homeDrawerCloseHeight)
        }
    }

    func setDelegate() {
        drawerView.habitTableView.delegate = self
        drawerView.habitTableView.dataSource = self
    }

    // MARK: - Protocols
}
