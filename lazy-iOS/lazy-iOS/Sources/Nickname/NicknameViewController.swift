//
//  NicknameViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/31.
//

import UIKit

// FIXME: - 행간 제발, 색상 픽스나면 변경
class NicknameViewController: UIViewController {
    // MARK: - UIComponenets
    
    let navigationBar = CustomNavigationBar("", state: .navigation)
    
    let guideLabel = UILabel().then {
        $0.text = "뭐라고 부르면 될까요?"
        $0.textColor = .textPrimary
        $0.font = .pretendard(type: .medium, size: 28)
    }
    
    let roundedView = RoundedView()
    
    let nicknameTextField = UITextField().then {
        $0.font = .pretendard(type: .medium, size: 18)
        $0.placeholder = "닉네임을 입력하세요"
        $0.textColor = .textPrimary
    }
    
    lazy var confirmButton = UIButton().then {
        $0.setTitle("회원가입 끝!", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .mainColor
    }
    
    // MARK: - Properties
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        confirmButton.cornerRounds()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .white
    }
    
    func setConstraints() {
        view.addSubviews([navigationBar, guideLabel, roundedView, confirmButton])
        roundedView.addSubviews([nicknameTextField])
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(40)
            make.leading.equalTo(nicknameTextField.snp.leading)
        }
        
        roundedView.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(335.0 / 375.0)
            make.height.equalTo(nicknameTextField.snp.width).multipliedBy(60.0 / 335.0)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(320.0 / 375.0)
            make.height.equalTo(confirmButton.snp.width).multipliedBy(60.0 / 320.0)
        }
    }
    
    // MARK: - Protocols
}
