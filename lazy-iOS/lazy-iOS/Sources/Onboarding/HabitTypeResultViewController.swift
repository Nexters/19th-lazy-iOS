//
//  HabitTypeResultViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/03.
//

import UIKit

class HabitTypeResultViewController: UIViewController {
    // MARK: - UIComponents

    let navigationBar = CustomNavigationBar("", state: .navigation)

    private let mainLabel = UILabel().then {
        $0.font = .pretendard(type: .medium, size: 24)
        $0.numberOfLines = 0
        $0.textColor = .gray8
    }

    private let subLabel = UILabel().then {
        $0.font = .pretendard(type: .medium, size: 16)
        $0.numberOfLines = 0
        $0.textColor = .gray6
        $0.lineSpacing(spacing: 5)
    }

    private let skipButton = UIButton().then {
        let text = "건너뛰기"
        let title = NSMutableAttributedString(string: text)
        title.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange(location: 0, length: text.count))
        $0.titleLabel?.font = .pretendard(type: .medium, size: 14)
        $0.titleLabel?.attributedText = title
        $0.setTitle(text, for: .normal)
        $0.setTitleColor(.gray6, for: .normal)
        $0.addTarget(self, action: #selector(didTapSkipButton(_:)), for: .touchUpInside)
    }

    lazy var nextButton = RoundedButton(style: .purple).then {
        $0.setTitle("저의 변화가 기대돼요", for: .normal)
        $0.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
    }

    // MARK: - Properties

    private var mainLabelTextArr = ["시작일을 지정하고\n얼마나 습관이 쌓였는지\n알려줄게요!", "당장 할 수 있는 습관을\n하나씩 해내보세요!", "이미 달성한 습관이 아닌,\n해야 할 습관을 누적해서\n보여줄게요!", "습관을 안하고 넘어간\n날에는 경각심을\n심어줄게요!"]
    private var subLabelTextArr = ["잊혀진 습관도 꾸준히 하도록\n밍굴맹굴이 계속 상기시켜줄게요", "어제 밀린 일을 없애고\n오늘 당장의 할 일에 집중해요", "습관이 누적되지 않아 휑한 일정표는\n아무런 자극이 되지 않았어요", "미처 못하고 지나가더라도\n얼마나 미뤘는지 알려드릴게요"]

    // MARK: - Initializer

    init(type: Int) {
        super.init(nibName: nil, bundle: nil)

        mainLabel.text = mainLabelTextArr[type]
        mainLabel.lineSpacing(spacing: 5)
        subLabel.text = subLabelTextArr[type]
        subLabel.lineSpacing(spacing: 5)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecyle

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setDelegate()
        setConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    // MARK: - Actions

    @objc func didTapSkipButton(_ sender: UIButton) {
        navigationController?.pushViewController(TabBarController(), animated: true)
    }

    @objc
    func didTapNextButton(_ sender: UIButton) {
        navigationController?.pushViewController(OnboardingViewController(), animated: true)
    }

    // MARK: - Methods

    func setView() {
        view.backgroundColor = .white
    }

    func setDelegate() {
        navigationBar.navigationDelegate = self
    }

    func setConstraints() {
        view.addSubviews([navigationBar, mainLabel, subLabel, skipButton, nextButton])

        // FIXME: - 네비바 영역이 안 잡혀있음
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }

        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(132 * DeviceConstants.heightRatio)
            make.leading.equalTo(20)
        }

        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(36 * DeviceConstants.heightRatio)
            make.leading.equalTo(mainLabel.snp.leading)
        }

        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65 * DeviceConstants.heightRatio)
            make.trailing.equalToSuperview().offset(-35)
        }

        nextButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(320.0 / 375.0)
            make.height.equalTo(nextButton.snp.width).multipliedBy(60.0 / 320.0)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30 * DeviceConstants.heightRatio)
        }
    }
}

extension HabitTypeResultViewController: NavigationDelegate {
    func pop() {
        navigationController?.popViewController(animated: true)
    }
}
