//
//  LabeledRoundedView.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/23.
//

import UIKit

enum AddHabitViewState {
    case setHabit
    case dayOfTheWeek
}

class LabeledRoundedView: UIView {
    // MARK: - UIComponenets

    private let titleLabel = UILabel().then {
        $0.font = .pretendard(type: .medium, size: 12)
        $0.text = "습관 설정"
    }

    // MARK: - Properties

    let accesoryView: UIView

    // MARK: - Initializer

    init(state: AddHabitViewState, _ accesoryView: UIView) {
        let title: String

        switch state {
        case .setHabit:
            title = "습관 설정"
        case .dayOfTheWeek:
            title = "요일 설정"
        }
        titleLabel.text = title
        self.accesoryView = accesoryView

        super.init(frame: .zero)

        setView()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions

    // MARK: - Methods

    func setView() {
        backgroundColor = UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1)
        cornerRound(radius: 20)
    }

    func setConstraints() {
        addSubviews([titleLabel, accesoryView])

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }

        accesoryView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12).priority(.low)
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalTo(titleLabel.snp.leading)
        }
    }
}
