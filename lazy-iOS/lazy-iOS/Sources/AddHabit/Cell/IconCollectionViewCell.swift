//
//  IconCollectionViewCell.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/23.
//

import UIKit

class IconCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponents

    // MARK: - Properties

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        contentView.cornerRounds()
    }

    // MARK: - Properties

    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = contentView.backgroundColor?.withAlphaComponent(1)
            } else {
                contentView.backgroundColor = contentView.backgroundColor?.withAlphaComponent(0.4)
            }
        }
    }

    // MARK: - Methods

    func setConstraints() {}
}
