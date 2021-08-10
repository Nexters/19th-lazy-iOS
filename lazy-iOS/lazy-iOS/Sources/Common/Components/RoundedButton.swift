//
//  RoundedButton.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/31.
//

import UIKit

enum RoundedButtonStyle {
    case purple
    case white
}

class RoundedButton: UIButton {
    // MARK: - Properties

    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                changeActive()
            } else {
                changeInactive()
            }
        }
    }

    var bgColor: UIColor?
    var labelColor: UIColor?

    /// 외부에서 스타일 변화 시 사용
    var style: RoundedButtonStyle = .purple {
        didSet {
            switch style {
            case .purple:
                backgroundColor = .mainPurple
                setTitleColor(.white, for: .normal)
            case .white:
                backgroundColor = .white
                setTitleColor(.gray1, for: .normal)
            }
        }
    }

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(style: RoundedButtonStyle) {
        self.init(frame: .zero)

        self.style = style

        switch style {
        case .purple:
            bgColor = .mainPurple
            labelColor = .white
        case .white:
            bgColor = .white
            labelColor = .gray1
        }

        setButton()
        changeActive()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        cornerRounds()
    }

    func setButton() {
        titleLabel?.font = .pretendard(type: .bold, size: 16)
    }

    func setBorderColor(color: UIColor) {
        layer.borderWidth = 1.0
        layer.borderColor = color.cgColor
    }

    func removeBorderColor() {
        layer.borderWidth = 0.0
    }

    func changeActive() {
        setTitleColor(labelColor, for: .normal)
        backgroundColor = bgColor
    }

    func changeInactive() {
        setTitleColor(.gray3, for: .disabled)
        backgroundColor = .gray5
    }
}
