//
//  IconCollectionViewCell.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/23.
//

import UIKit

class IconCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponents

    let iconImageView = UIImageView()

    // MARK: - Properties

    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
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
                iconImageView.alpha = 1
            } else {
                iconImageView.alpha = 0.4
            }
        }
    }

    // MARK: - Methods

    func setConstraints() {
        contentView.addSubview(iconImageView)

        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setIconImage(idx: Int) {
        iconImageView.image = BubbleIcon(rawValue: idx)?.iconImage
    }
}
