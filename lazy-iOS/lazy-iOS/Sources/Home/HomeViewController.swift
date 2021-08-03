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

    let backgroundShadowImageView = UIImageView().then {
        $0.image = UIImage(named: "txtBg")
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
    }

    let notificationLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .pretendard(type: .bold, size: 14)
        $0.text = Date().dateToString(format: "yy.d.M EEEE", date: Date())
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

                let randomImage = Int.random(in: 1 ... 2)
                let bubble = UIView(frame: CGRect(x: randomX, y: 100, width: size, height: size))

                let bubbleIcon = UIImageView(image: UIImage(named: "habbit\(randomImage)"))
                bubbleIcon.contentMode = .scaleAspectFit
                bubble.cornerRounds()
                bubble.backgroundColor = [UIColor.systemBlue, UIColor.systemPink, UIColor.systemOrange].randomElement()

                bubble.gestureRecognizers = [UIPanGestureRecognizer(target: self, action: #selector(self.handleBubbleView(_:)))]

                bubble.addSubview(bubbleIcon)
                self.view.addSubview(bubble)
                BubbleBehaviorManager.bubbleBehavior.addBubble(bubble)
            }
        }
    }

    func setConstraints() {
        view.addSubviews([backgroundImageView, bubbleView, drawerView, backgroundShadowImageView, notificationLabel])

        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        backgroundShadowImageView.snp.makeConstraints { make in
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
