//
//  ConfirmViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/01.
//

import UIKit

class ConfirmViewController: UIViewController {
    // MARK: - UIComponents

    private let nicknameLabel = UILabel().then {
        $0.font = .pretendard(type: .medium, size: 28)
        $0.text = "밍굴맹굴님"
        $0.textColor = .mainPurple

        if let text = $0.text {
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(.foregroundColor, value: UIColor.gray1, range: (text as NSString).range(of: "님"))
            $0.attributedText = attributedStr
        }
    }

    private let mainLabel = UILabel().then {
        $0.font = .pretendard(type: .bold, size: 24)
        $0.text = "습관을 세우고 한 번도\n실행하지 않았다구요?"
        $0.numberOfLines = 0
        $0.textColor = .gray1
        $0.lineSpacing(spacing: 5)
    }

    private let subLabel = UILabel().then {
        $0.font = .pretendard(type: .medium, size: 16)
        $0.text = "습관이 누적되지 않아 휑한 일정표를\n많이 경험하진 않았나요?"
        $0.numberOfLines = 0
        $0.textColor = .gray3
        $0.lineSpacing(spacing: 5)
    }

    private let skipButton = UIButton().then {
        let text = "건너뛰기"
        let title = NSMutableAttributedString(string: text)
        title.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange(location: 0, length: text.count))
        $0.titleLabel?.font = .pretendard(type: .medium, size: 14)
        $0.titleLabel?.attributedText = title
        $0.setTitle(text, for: .normal)
        $0.setTitleColor(.gray3, for: .normal)
        $0.addTarget(self, action: #selector(didTapSkipButton(_:)), for: .touchUpInside)
    }

    private let nextButton = RoundedButton(style: .purple).then {
        $0.setTitle("이거 완전 제 얘기에요", for: .normal)
        $0.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
    }

    // MARK: - Lifecyle

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setConstraints()
    }

    // MARK: - Actions

    @objc func didTapNextButton(_ sender: UIButton) {
        navigationController?.pushViewController(OnboardingViewController(), animated: true)
    }

    @objc func didTapSkipButton(_ sender: UIButton) {
        navigationController?.pushViewController(TabBarController(), animated: true)
    }

    // MARK: - Methods

    func setView() {
        view.backgroundColor = .white
    }

    func setConstraints() {
        view.addSubviews([nicknameLabel, mainLabel, subLabel, skipButton, nextButton])

        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(132 * DiviceConstants.heightRatio)
            make.leading.equalToSuperview().offset(20)
        }

        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(21 * DiviceConstants.heightRatio)
            make.leading.equalTo(nicknameLabel.snp.leading)
        }

        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(36 * DiviceConstants.heightRatio)
            make.leading.equalTo(mainLabel.snp.leading)
        }

        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65 * DiviceConstants.heightRatio)
            make.trailing.equalToSuperview().offset(-35)
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30 * DiviceConstants.heightRatio)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(320.0 / 375.0)
            make.height.equalTo(nextButton.snp.width).multipliedBy(60.0 / 320.0)
        }
    }
}
