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

    // FIXME: - 정확히 반대로 동작함!
    override var isSelected: Bool {
        willSet {
            if isSelected {
                contentView.backgroundColor = contentView.backgroundColor?.withAlphaComponent(1)
            } else {
                contentView.backgroundColor = contentView.backgroundColor?.withAlphaComponent(0.3)
            }
        }
    }

    override func prepareForReuse() {
        isSelected = false
    }

    // MARK: - Methods

    func setConstraints() {}
}
