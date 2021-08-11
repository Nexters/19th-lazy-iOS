//
//  HabitButtonCollectionViewCell.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/10.
//

import UIKit

class HabitButtonCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponenets
    
    let button = RoundedButton(style: .white)
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        button.setTitle("런데이하기", for: .normal)
        button.setBorderColor(color: UIColor(228, 228, 228, 1))
        button.titleLabel?.font = .pretendard(type: .medium, size: 12)
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        button.snp.updateConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    // MARK: - Methods

    func setConstraints() {
        contentView.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
