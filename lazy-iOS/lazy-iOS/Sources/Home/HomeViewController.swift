//
//  ViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/10.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - UIComponenets

    let backgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "bg")
    }

    let backgroundShadowView = UIView()

    let notificationLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .pretendard(type: .bold, size: 14)
        $0.text = Date().dateToString(format: "yy.M.d EEEE", date: Date())
    }

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

        backgroundShadowView.setGradient(color1: UIColor(80, 68, 222, 1.0), color2: UIColor.mainPurple.withAlphaComponent(0.0))
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
        overrideUserInterfaceStyle = .dark

        animator.addBehavior(BubbleBehaviorManager.bubbleBehavior)

        for idx in 0 ... 6 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(idx * 400)) {
                let x = self.view.bounds.width / 4.0
                let randomX = CGFloat.random(in: x - 70 ..< x + 70)
                let size = UIScreen.main.bounds.width * (150.0 / 375.0)

                let bubble = UIView(frame: CGRect(x: randomX, y: 100, width: size, height: size))
                bubble.cornerRounds()
                bubble.gestureRecognizers = [UIPanGestureRecognizer(target: self, action: #selector(self.handleBubbleView(_:)))]

                let randomImage = Int.random(in: 1 ... 2)
                let bubbleIcon = UIImageView(image: UIImage(named: "habbit\(randomImage)"))

                bubble.addSubview(bubbleIcon)
                bubbleIcon.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }

                self.view.addSubview(bubble)
                BubbleBehaviorManager.bubbleBehavior.addBubble(bubble)
            }
        }
    }

    func setConstraints() {
        view.addSubviews([backgroundImageView, bubbleView, drawerView, backgroundShadowView, notificationLabel])

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backgroundShadowView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(110 * DeviceConstants.heightRatio)
        }

        notificationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(62 * DeviceConstants.heightRatio)
            make.centerX.equalToSuperview()
        }

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
