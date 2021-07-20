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

    let iconView = UIView().then {
        $0.backgroundColor = .systemOrange
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
        $0.setTitle("3일 차", for: .normal)
        $0.titleLabel?.font = .pretendard(type: .bold, size: 12)
        $0.tintColor = .black
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setView()
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
    
    override func layoutSubviews() {
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 22, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
        
        checkButton.cornerRound(radius: 17 * UIScreen.main.bounds.width / 375.0)
        iconView.cornerRounds()
        
        super.layoutSubviews()
    }
    
    // MARK: - Methods
    
    func setView() {
        backgroundColor = .white
    }
    
    func setConstraints() {
        contentView.addSubviews([iconView, titleLabel, commentLabel, checkButton])
        
        iconView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(34)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconView.snp.top).offset(-1)
            make.leading.equalTo(iconView.snp.trailing).offset(12)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalTo(iconView.snp.bottom).offset(2)
        }
        
        checkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(54)
            make.height.equalTo(34)
            make.centerY.equalToSuperview()
        }
        
        iconView.layoutIfNeeded()
    }
}
