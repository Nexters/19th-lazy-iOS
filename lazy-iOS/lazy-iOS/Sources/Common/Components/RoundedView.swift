//
//  RoundedView.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/23.
//

import UIKit

class RoundedView: UIView {
    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func setView() {
        backgroundColor = UIColor(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1)
        cornerRound(radius: 18)
    }
}
