//
//  HabitCheckButton.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/30.
//

import UIKit

class HabitCheckButton: UIButton {
    // MARK: - Properties

    override var isSelected: Bool {
        didSet {
            if isSelected {
                /// 완료
                changeDone()
            } else {
                /// 미완료
                changeActive()
            }
        }
    }

    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                changeActive()
            } else {
                /// 비활성
                changeInActive()
            }
        }
    }

    init(_ day: Int = 0) {
        super.init(frame: .zero)

        setTitleColor(.textPrimary, for: .normal)
        setTitleColor(.textSecondary, for: .selected)

        setTitle("\(day)일 차", for: .normal)
        setTitle("완료", for: .selected)

        titleLabel?.font = .pretendard(type: .bold, size: 12)
        clipsToBounds = false

        isSelected = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func changeActive() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.textPrimary.cgColor

        backgroundColor = .clear
        setTitleColor(.textPrimary, for: .normal)
    }

    private func changeInActive() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.textCaption.cgColor

        backgroundColor = .clear
        setTitleColor(.textCaption, for: .normal)
    }

    private func changeDone() {
        layer.borderWidth = 0.0
        layer.borderColor = UIColor.clear.cgColor

        backgroundColor = UIColor(235, 234, 237, 1)
    }
}
