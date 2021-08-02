//
//  LoginViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/11.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - UIComponenets
    
    private lazy var kakaoLoginButton = UIButton().then {
        $0.backgroundColor = UIColor(254, 229, 0, 1)
        $0.setTitle("카카오톡으로 로그인", for: .normal)
        $0.setTitleColor(.black.withAlphaComponent(0.85), for: .normal)
        $0.titleLabel?.font = .pretendard(type: .medium, size: 16)
        $0.addTarget(self, action: #selector(handleKakaoLoginButton(_:)), for: .touchUpInside)
        
        let logo = UIImageView(image: UIImage(named: "iconKakao")?.withTintColor(.black, renderingMode: .alwaysOriginal))
        $0.addSubview(logo)
        logo.snp.makeConstraints { make in
            make.leading.equalTo(18)
            make.centerY.equalToSuperview()
        }
    }
    
    private lazy var appleLoginButton = UIButton().then {
        $0.backgroundColor = .black
        $0.setTitle("Apple로 로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .pretendard(type: .medium, size: 16)
        $0.addTarget(self, action: #selector(handleAppleLoginButton(_:)), for: .touchUpInside)
        
        let logo = UIImageView(image: UIImage(named: "iconApple"))
        $0.addSubview(logo)
        logo.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.centerY.equalToSuperview()
        }
    }
    
    let backgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "bg")
    }
    
    let mainLabel = UILabel().then {
        $0.text = "더 이상의 게으름은\n용납할 수 없다."
        $0.numberOfLines = 0
        $0.font = .pretendard(type: .medium, size: 28)
        $0.textColor = .white
        $0.lineSpacing(spacing: 5)
    }
    
    let subLabel = UILabel().then {
        $0.text = "어제보다 발전할 오늘을 위해,\n오늘도 밍굴맹굴이 움직이게 유도할게요!"
        $0.numberOfLines = 0
        $0.font = .pretendard(type: .regular, size: 14)
        $0.textColor = .white
        $0.lineSpacing(spacing: 5)
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        kakaoLoginButton.cornerRounds()
        appleLoginButton.cornerRounds()
    }
    
    // MARK: - Actions
    
    @objc
    func handleKakaoLoginButton(_ sender: UIButton) {
        SignManager.shared.requestLoginWithKakao {
            self.navigationController?.pushViewController(NicknameViewController(), animated: true)
        }
    }
    
    @objc
    func handleAppleLoginButton(_ sender: UIButton) {
        SignManager.shared.requestLoginWithApple {
            self.navigationController?.pushViewController(TabBarController(), animated: true)
        }
    }
    
    // MARK: - Methods
    
    func setConstraints() {
        view.addSubviews([backgroundImageView, kakaoLoginButton, appleLoginButton, mainLabel, subLabel])
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(320.0 / 375.0)
            make.height.equalTo(kakaoLoginButton.snp.width).multipliedBy(60.0 / 320.0)
            make.bottom.equalTo(appleLoginButton.snp.top).offset(-12)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.width.equalToSuperview().multipliedBy(320.0 / 375.0)
            make.height.equalTo(appleLoginButton.snp.width).multipliedBy(60.0 / 320.0)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subLabel.snp.top).offset(-20)
            make.leading.equalTo(subLabel.snp.leading)
        }
        
        subLabel.snp.makeConstraints { make in
            make.bottom.equalTo(kakaoLoginButton.snp.top).offset(-60)
            make.leading.equalTo(kakaoLoginButton.snp.leading)
        }
    }
    
    // MARK: - Protocols
}
