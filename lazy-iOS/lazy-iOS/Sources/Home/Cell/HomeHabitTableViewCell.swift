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

    let iconView = UIImageView()
    
    let titleLabel = UILabel().then {
        $0.text = "습관 A"
        $0.font = .pretendard(type: .bold, size: 16)
        $0.textColor = .black
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }
    
    let commentLabel = UILabel().then {
        $0.text = "와우, 대단해요!"
        $0.font = .pretendard(type: .medium, size: 12)
        $0.textColor = .darkGray
    }
    
    lazy var checkButton = HabitCheckButton().then {
        $0.addTarget(self, action: #selector(didTapCheckButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Properties

    // FIXME: - 안 쓰는 것 같은데요...
    var checkButtonDelegate: HabitCheckButtonDelegate?
    var habit: Habit?

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
    
    override func prepareForReuse() {
        changeActive()
        habit = nil
    }
    
    // MARK: - Actions
    
    @objc
    func didTapCheckButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        guard let habit = self.habit else { return }
        HabitManager.shared.completionHabit(target: habit, isCompletion: sender.isSelected)
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
            make.leading.equalTo(iconView.snp.trailing).offset(12.0 * DeviceConstants.widthRatio)
            make.trailing.equalTo(checkButton.snp.leading).offset(-86.0 * DeviceConstants.widthRatio)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.bottom.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(54.0 * DeviceConstants.widthRatio)
            make.height.equalTo(checkButton.snp.width).multipliedBy(34.0 / 54.0)
            make.centerY.equalToSuperview()
        }
    }
    
    // FIXME: - 예쁘게 고쳐야겠죠..
    func setHabitData(habit: Habit) {
        self.habit = habit
        
        iconView.image = UIImage(named: "habbit\(habit.iconIdx)")
        titleLabel.text = habit.name
        
        let todayWeekDay = Calendar.current.dateComponents([.weekday], from: Date()).weekday ?? 0
        
        if habit.completion {
            commentLabel.text = "와우! 대단해요"
            checkButton.isSelected = true
        } else {
            commentLabel.text = "얼마 남았어요"
            checkButton.isSelected = false
        }
        
        checkButton.setTitle("\(habit.delayDay)일 차", for: .normal)
        
        if !habit.repeatDays.contains(todayWeekDay) {
            changeInActive()
        }
    }
    
    func changeInActive() {
        iconView.alpha = 0.5
        titleLabel.alpha = 0.5
        commentLabel.alpha = 0.5
        
        checkButton.isEnabled = false
    }
    
    func changeActive() {
        iconView.alpha = 1.0
        titleLabel.alpha = 1.0
        commentLabel.alpha = 1.0
        
        checkButton.isEnabled = true
    }
}
