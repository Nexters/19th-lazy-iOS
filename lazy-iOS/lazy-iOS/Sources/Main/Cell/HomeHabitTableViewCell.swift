//
//  HomeHabitTableViewCell.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/20.
//

import UIKit

class HomeHabitTableViewCell: UITableViewCell {
    static let identifier = "HomeHabitTableViewCell"

    // MARK: - UIComponents

    let iconImage = UIImageView().then {
        $0.image = UIImage(systemName: "house.fill")
    }
    
    let titleLabel = UILabel().then {
        $0.text = "습관 A"
        $0.font = .pretendard(type: .bold, size: 16)
        $0.textColor = .black
    }
    
    let commentLabel = UILabel().then {
        $0.text = "와우, 대단해요!"
        $0.font = .pretendard(type: .medium, size: 12)
        $0.textColor = .darkGray
    }
    
    let checkButton = UIButton().then {
        $0.setTitle("3일 째", for: .normal)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Methods
    
    func setConstraints() {
        contentView.addSubviews([iconImage, titleLabel, commentLabel, checkButton])
        
        iconImage.snp.makeConstraints { make in
            make.width.height.equalToSuperview().multipliedBy(40.0 / 375.0)
            make.leading.equalToSuperview().offset(20)
            make.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImage.snp.top)
            make.leading.equalTo(iconImage.snp.trailing).offset(15)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalTo(iconImage.snp.bottom)
        }
        
        checkButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(72.0 / 375.0)
            make.height.equalTo(32)
        }
    }
}
