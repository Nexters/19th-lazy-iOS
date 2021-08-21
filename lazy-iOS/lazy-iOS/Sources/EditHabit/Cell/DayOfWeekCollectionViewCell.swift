//
//  DayOfWeekCollectionViewCell.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/23.
//

import UIKit

class DayOfWeekCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponents
    
    var dayLabel = UILabel().then {
        $0.font = .pretendard(type: .medium, size: 16)
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setConstraints()
        isSelected = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .mainPurple
                dayLabel.textColor = .white
            } else {
                contentView.backgroundColor = .gray3
                dayLabel.textColor = .gray8
            }
        }
    }
    
    override func layoutSubviews() {
        contentView.cornerRounds()
    }
    
    override func prepareForReuse() {
        isSelected = false
    }
    
    // MARK: - Methods
    
    func setConstraints() {
        contentView.addSubviews([dayLabel])
        
        dayLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // FIXME: - 데이터 바뀌겠지 ... 임시...
    func setCell(day: String) {
        dayLabel.text = day
    }
}
