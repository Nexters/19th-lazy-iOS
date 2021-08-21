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

    let emptyLabel = UILabel().then {
        $0.font = .pretendard(type: .semiBold, size: 18)
        $0.text = "아직 등록된 습관이 없어요"
        $0.textColor = .white
    }

    let emptySubLabel = UILabel().then {
        $0.font = .pretendard(type: .regular, size: 14)
        $0.text = "새로운 습관을 추가해보세요!"
        $0.textColor = .gray4
        $0.lineSpacing(spacing: 8)
    }

    let addHabitButton = RoundedButton(style: .purple).then {
        $0.setTitle("추가하기", for: .normal)
        $0.addTarget(self, action: #selector(didTapAddHabitButton(_:)), for: .touchUpInside)
    }

    // MARK: - Properties

    lazy var animator = UIDynamicAnimator(referenceView: self.bubbleAreaView)
    let bubbleAreaView = UIView().then {
        $0.backgroundColor = .clear
    }

    let drawerView = DrawerView()

    var isHabitEmpty: Bool = false {
        didSet {
            if isHabitEmpty {
                backgroundImageView.isHidden = true
                backgroundShadowView.isHidden = true
                bubbleAreaView.isHidden = true
                drawerView.isHidden = true

                emptyLabel.isHidden = false
                emptySubLabel.isHidden = false
                addHabitButton.isHidden = false
            } else {
                backgroundImageView.isHidden = false
                backgroundShadowView.isHidden = false
                bubbleAreaView.isHidden = false
                drawerView.isHidden = false

                emptyLabel.isHidden = true
                emptySubLabel.isHidden = true
                addHabitButton.isHidden = true
            }
        }
    }

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

    @objc
    func didTapAddHabitButton(_ sender: UIButton) {
        present(EditHabitViewController(mode: .add), animated: true, completion: nil)
    }

    // MARK: - Methods

    func setView() {
        view.backgroundColor = .mainDark
        overrideUserInterfaceStyle = .dark

        animator.addBehavior(BubbleBehaviorManager.shared)
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
            make.bottom.equalTo(drawerView.snp.top).offset(-2)
            make.height.equalTo(view.snp.height).offset(500)
        }

        drawerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(50)
            make.height.equalTo(UIComponentsConstants.homeDrawerOpenHeight)
        }

        /// empty
        view.addSubviews([emptyLabel, emptySubLabel, addHabitButton])

        emptyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(295 * DeviceConstants.heightRatio)
            make.centerX.equalToSuperview()
        }

        emptySubLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }

        addHabitButton.snp.makeConstraints { make in
            make.top.equalTo(emptySubLabel.snp.bottom).offset(25)
            make.width.equalTo(80 * DeviceConstants.widthRatio)
            make.height.equalTo(42 * DeviceConstants.heightRatio)
            make.centerX.equalToSuperview()
        }
    }

    func setDelegate() {
        drawerView.habitTableView.delegate = self
        drawerView.habitTableView.dataSource = self
        drawerView.drawerViewDelegate = self

        HabitManager.shared.homeHabitManagerDelegate = self
    }

    func fetchHabitsData() {
        /// 서버 통신
        let habits = [Habit(idx: 3, iconIdx: 2, name: "런데이! 🏃🏼‍♀️", frequency: 5, delayDay: 6, registrationDate: Date(), isAlarm: true, repeatDays: [1, 3, 5, 7], completion: false), Habit(idx: 4, iconIdx: 1, name: "1일 1알고리즘", frequency: 5, delayDay: 2, registrationDate: Date(), isAlarm: true, repeatDays: [1, 2, 3, 4, 5, 6, 7], completion: false)]

//        HabitManager.shared.appendHabits(habits)
        HabitManager.shared.refreshHabits(habits)
    }
}

// TODO: - 버블 사이즈 enum
extension HomeViewController: HomeHabitManagerDelegate {
    func emptyHabit() {
        isHabitEmpty = true

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            print(self.bubbleAreaView.subviews)
            self.bubbleAreaView.subviews.forEach { $0.removeFromSuperview() }
        }
    }

    func addHabits(_ habits: [Habit]) {
        isHabitEmpty = false

        let x = view.bounds.width / 4.0
        let size = HabitManager.shared.bubbleSize * DeviceConstants.widthRatio

        for (idx, habit) in habits.enumerated() {
            for habitIdx in 0 ..< habit.delayDay {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds((idx + habitIdx) * 300)) {
                    let randomX = CGFloat.random(in: x - 70 ..< x + 70)
                    let bubbleView = BubbleView(frame: CGRect(x: randomX, y: 100, width: size, height: size))
                    bubbleView.gestureDelegate = self
                    bubbleView.habit = habit

                    self.bubbleAreaView.addSubview(bubbleView)
                    BubbleBehaviorManager.shared.addBubble(bubbleView)
                }
            }
        }
    }

    func completedHabit(habit: Habit) {
        print("\(habit.name) 습관 완료 😀")
    }

    func incompleteHabit(habit: Habit) {
        print("\(habit.name) 습관 미완료 🤬")
    }
}
