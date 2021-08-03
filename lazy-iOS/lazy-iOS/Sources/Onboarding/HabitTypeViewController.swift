//
//  HabitTypeViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/03.
//

import UIKit

class HabitTypeViewController: UIViewController {
    // MARK: - UIComponents

    private let nicknameLabel = UILabel().then {
        $0.font = .pretendard(type: .medium, size: 28)
        $0.text = "밍굴맹굴님의\n습관 유형은 무엇인가요?"
        $0.numberOfLines = 0
        $0.textColor = .gray1
        $0.lineSpacing(spacing: 5)

        if let text = $0.text {
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(.foregroundColor, value: UIColor.mainPurple, range: (text as NSString).range(of: "밍굴맹굴"))
            $0.attributedText = attributedStr
        }
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

    lazy var type0Button = RoundedButton(style: .white).then {
        $0.setTitle("앗 내게 습관이 있었던가?", for: .normal)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.gray1.cgColor
        $0.addTarget(self, action: #selector(didTapTypeButton(_:)), for: .touchUpInside)
        $0.tag = 0
    }

    lazy var type1Button = RoundedButton(style: .white).then {
        $0.setTitle("습관 계획세우기 귀찮아요", for: .normal)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.gray1.cgColor
        $0.addTarget(self, action: #selector(didTapTypeButton(_:)), for: .touchUpInside)
        $0.tag = 1
    }

    lazy var type2Button = RoundedButton(style: .white).then {
        $0.setTitle("습관달성한 날이 손에 꼽아요", for: .normal)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.gray1.cgColor
        $0.addTarget(self, action: #selector(didTapTypeButton(_:)), for: .touchUpInside)
        $0.tag = 2
    }

    lazy var type3Button = RoundedButton(style: .white).then {
        $0.setTitle("습관 뺴먹은 날이 너무 아까워요", for: .normal)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.gray1.cgColor
        $0.addTarget(self, action: #selector(didTapTypeButton(_:)), for: .touchUpInside)
        $0.tag = 3
    }

    // MARK: - Properties

    // MARK: - Lifecyle

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setConstraints()
    }

    // MARK: - Actions

    @objc func didTapSkipButton(_ sender: UIButton) {
        navigationController?.pushViewController(TabBarController(), animated: true)
    }

    @objc func didTapTypeButton(_ sender: UIButton) {
        navigationController?.pushViewController(HabitTypeResultViewController(type: sender.tag), animated: true)
    }

    // MARK: - Methods

    func setView() {
        view.backgroundColor = .white
    }

    func setConstraints() {
        view.addSubviews([nicknameLabel, skipButton, type0Button, type1Button, type2Button, type3Button])

        nicknameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(132 * DiviceConstants.heightRatio)
            make.leading.equalToSuperview().offset(20)
        }

        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65 * DiviceConstants.heightRatio)
            make.trailing.equalToSuperview().offset(-35)
        }

        type0Button.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(84 * DiviceConstants.heightRatio)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(320.0 / 375.0)
            make.height.equalTo(type0Button.snp.width).multipliedBy(60.0 / 320.0)
        }

        type1Button.snp.makeConstraints { make in
            make.top.equalTo(type0Button.snp.bottom).offset(20 * DiviceConstants.heightRatio)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(320.0 / 375.0)
            make.height.equalTo(type0Button.snp.width).multipliedBy(60.0 / 320.0)
        }

        type2Button.snp.makeConstraints { make in
            make.top.equalTo(type1Button.snp.bottom).offset(20 * DiviceConstants.heightRatio)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(320.0 / 375.0)
            make.height.equalTo(type0Button.snp.width).multipliedBy(60.0 / 320.0)
        }

        type3Button.snp.makeConstraints { make in
            make.top.equalTo(type2Button.snp.bottom).offset(20 * DiviceConstants.heightRatio)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(320.0 / 375.0)
            make.height.equalTo(type0Button.snp.width).multipliedBy(60.0 / 320.0)
        }
    }
}
