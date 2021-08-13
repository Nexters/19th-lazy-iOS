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

    lazy var animator = UIDynamicAnimator(referenceView: self.bubbleAreaView)
    let bubbleAreaView = UIView().then {
        $0.backgroundColor = .clear
    }

    let drawerView = DrawerView()

    // MARK: - Initializer

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setDelegate()
        setConstraints()
        fetchHabitsData()
    }

    override func viewWillAppear(_ animated: Bool) {
        BubbleBehaviorManager.shared.collisionBehavior.collisionDelegate = BubbleBehaviorManager.shared
        BubbleBehaviorManager.shared.updateBubblePosition()

//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        BubbleBehaviorManager.shared.collisionBehavior.collisionDelegate = nil
        BubbleBehaviorManager.shared.stopBubble()
    }

    override func viewWillLayoutSubviews() {
        backgroundShadowView.setGradient(color1: UIColor(80, 68, 222, 1.0), color2: UIColor.mainPurple.withAlphaComponent(0.0))
    }

    // MARK: - Actions

    // MARK: - Methods

    func setView() {
        overrideUserInterfaceStyle = .dark

        animator.addBehavior(BubbleBehaviorManager.shared)

        for idx in 0 ... 6 {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(idx * 400)) {
                let x = self.view.bounds.width / 4.0
                let randomX = CGFloat.random(in: x - 70 ..< x + 70)
                let size = 150.0 * DeviceConstants.widthRatio

                let bubbleView = BubbleView(frame: CGRect(x: randomX, y: 100, width: size, height: size))
                bubbleView.gestureDelegate = self

                self.bubbleAreaView.addSubview(bubbleView)
                BubbleBehaviorManager.shared.addBubble(bubbleView)
            }
        }
    }

    func setConstraints() {
        view.addSubviews([backgroundImageView, bubbleAreaView, drawerView, backgroundShadowView, notificationLabel])

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

        bubbleAreaView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(drawerView.snp.top).offset(3)
            make.height.equalTo(view.snp.height).offset(500)
        }

        drawerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(50)
            make.height.equalTo(drawerView.tableViewContentHeight)
        }
    }

    func setDelegate() {
        drawerView.habitTableView.delegate = self
        drawerView.habitTableView.dataSource = self
        drawerView.drawerViewDelegate = self
    }

    func fetchHabitsData() {
        /// 서버 통신
        let habits = [Habit(idx: 3, iconIdx: 2, name: "런데이! 🏃🏼‍♀️", frequency: 5, delayDay: 6, registrationDate: Date(), isAlarm: true, repeatDays: [1, 3, 5, 7], completion: false), Habit(idx: 4, iconIdx: 1, name: "1일 1알고리즘", frequency: 5, delayDay: 2, registrationDate: Date(), isAlarm: true, repeatDays: [1, 2, 3, 4, 5, 6, 7], completion: false)]

        HabitManager.shared.appendHabits(habits)
    }
}
