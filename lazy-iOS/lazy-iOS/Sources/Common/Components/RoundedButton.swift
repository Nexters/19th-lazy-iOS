//
//  RoundedButton.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/31.
//

import UIKit

enum ButtonColor {
    case purple
    case white
}

class RoundedButton: UIButton {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .mainPurple
            }
//            else {
//                backgroundColor = .
//            }
        }
    }

    // MARK: - Properties

    let mainColor: ButtonColor

    // MARK: - Initializer

    init(color: ButtonColor = .purple) {
        mainColor = color
        
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
