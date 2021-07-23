//
//  DayOfWeekCollectionViewCell.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/23.
//

import UIKit

class DayOfWeekCollectionViewCell: UICollectionViewCell {
    // MARK: - UIComponents
    
    var dayLabel = UILabel()
    
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
                contentView.backgroundColor = UIColor(red: 80.0 / 255.0, green: 68.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
                dayLabel.textColor = .white
            } else {
                contentView.backgroundColor = UIColor(red: 231.0 / 255.0, green: 231.0 / 255.0, blue: 231.0 / 255.0, alpha: 1)
                dayLabel.textColor = .black
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
