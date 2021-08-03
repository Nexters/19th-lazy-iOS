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
        BubbleBehaviorManager.bubbleBehavior.collisionBehavior.collisionDelegate = BubbleBehaviorManager.bubbleBehavior
        BubbleBehaviorManager.bubbleBehavior.updateBubblePosition()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        BubbleBehaviorManager.bubbleBehavior.collisionBehavior.collisionDelegate = nil
        BubbleBehaviorManager.bubbleBehavior.stopBubble()
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

        animator.addBehavior(BubbleBehaviorManager.bubbleBehavior)

        for idx in 0 ... 6 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(idx * 400)) {
                let x = self.view.bounds.width / 4.0
                let randomX = CGFloat.random(in: x - 70 ..< x + 70)
                let size = UIScreen.main.bounds.width * (150.0 / 375.0)

                let bubbleView = UIView(frame: CGRect(x: randomX, y: 100, width: size, height: size))
                bubbleView.cornerRounds()
                bubbleView.backgroundColor = [UIColor.systemBlue, UIColor.systemPink, UIColor.systemOrange].randomElement()

                bubbleView.gestureRecognizers = [UIPanGestureRecognizer(target: self, action: #selector(self.handleBubbleView(_:)))]

                self.view.addSubview(bubbleView)
                BubbleBehaviorManager.bubbleBehavior.addBubble(bubbleView)
            }
        }
    }

    func setConstraints() {
        view.addSubviews([bubbleView, drawerView])

        bubbleView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(drawerView.snp.top).offset(3)
            make.height.equalTo(view.snp.height).offset(500)
        }

        drawerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(50)
            make.height.equalTo(UIComponentsConstants.homeDrawerOpenHeight)
        }
    }

    func setDelegate() {
        drawerView.habitTableView.delegate = self
        drawerView.habitTableView.dataSource = self
        drawerView.drawerViewDelegate = self
    }

    // MARK: - Protocols
}
