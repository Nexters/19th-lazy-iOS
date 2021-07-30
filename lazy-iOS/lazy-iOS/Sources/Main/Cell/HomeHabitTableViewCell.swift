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
    
    lazy var checkButton = HabitCheckButton().then {
        $0.addTarget(self, action: #selector(didTapCheckButton(_:)), for: .touchUpInside)
    }

    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setCell()
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
        super.layoutSubviews()
        
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 22, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
        
        checkButton.cornerRound(radius: 17 * UIScreen.main.bounds.width / 375.0)
        iconView.cornerRound(radius: 18)
    }
    
    // MARK: - Actions
    
    @objc
    func didTapCheckButton(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    // MARK: - Methods
    
    func setCell() {
        backgroundColor = .white
        contentView.isUserInteractionEnabled = true
    }
    
    func setConstraints() {
        contentView.addSubviews([iconView, titleLabel, commentLabel, checkButton])
        
        iconView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(1)
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(iconView.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(iconView.snp.trailing).offset(12)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalToSuperview().multipliedBy(54.0 / 375.0)
            make.height.equalTo(checkButton.snp.width).multipliedBy(34.0 / 54.0)
            make.centerY.equalToSuperview()
        }
    }
}
