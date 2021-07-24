//
//  AddHabitViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/22.
//

import UIKit

class AddHabitViewController: UIViewController {
    // MARK: - UIComponenets
    
    lazy var habitSettingView = LabeledRoundedView(state: .setHabit, habitNameTextField)
    lazy var habitNameTextField = UITextField().then {
        $0.placeholder = "습관을 써주세요"
        $0.font = .pretendard(type: .medium, size: 18)
    }
    
    lazy var dayOfWeekSettingView = LabeledRoundedView(state: .dayOfTheWeek, dayOfWeekCollectionView)
    lazy var dayOfWeekCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.setCollectionViewLayout(layout, animated: true)
        $0.allowsMultipleSelection = true
        $0.dataSource = self
        $0.delegate = self
        $0.automaticallyAdjustsScrollIndicatorInsets = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        
        $0.register(cell: DayOfWeekCollectionViewCell.self)
    }
    
    let iconSettingView = RoundedView()
    lazy var iconCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.setCollectionViewLayout(layout, animated: true)
        $0.dataSource = self
        $0.delegate = self
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        
        $0.register(cell: IconCollectionViewCell.self)
    }

    // MARK: - Properties
    
    var weeks = ["일", "월", "화", "수", "목", "금", "토"]
    var colors = [UIColor.icon1, UIColor.icon2, UIColor.icon3, UIColor.icon4, UIColor.icon5, UIColor.icon6, UIColor.icon7, UIColor.icon8]
    var isFirst: Bool = true
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .white
    }
    
    func setConstraints() {
        view.addSubviews([habitSettingView, dayOfWeekSettingView, iconSettingView])
        iconSettingView.addSubview(iconCollectionView)
        
        habitSettingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(335.0 / 375.0)
            make.centerX.equalToSuperview()
        }
        
        dayOfWeekSettingView.snp.makeConstraints { make in
            make.top.equalTo(habitSettingView.snp.bottom).offset(44)
            make.leading.trailing.equalTo(habitSettingView)
            make.centerX.equalToSuperview()
        }
        
        iconSettingView.snp.makeConstraints { make in
            make.top.equalTo(dayOfWeekSettingView.snp.bottom).offset(44)
            make.leading.trailing.equalTo(habitSettingView)
            make.centerX.equalToSuperview()
        }
        
        iconCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(14)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(42).priority(.low)
        }
    }
    
    // MARK: - Protocols
}
