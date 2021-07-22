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
    
    // MARK: - Properties
    
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
        view.addSubviews([habitSettingView])
        
        habitSettingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview().multipliedBy(335.0 / 375.0)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Protocols
}
