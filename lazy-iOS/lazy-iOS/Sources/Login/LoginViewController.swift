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
    }
    
    private lazy var appleLoginButton = UIButton().then {
        $0.backgroundColor = .black
        $0.setTitle("Apple로 로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .pretendard(type: .medium, size: 16)
        $0.addTarget(self, action: #selector(handleAppleLoginButton(_:)), for: .touchUpInside)
        
        let logo = UIImageView(image: UIImage(named: "Left White Logo Large"))
        $0.addSubview(logo)
        logo.snp.makeConstraints { make in
            make.leading.equalTo(15)
            make.centerY.equalToSuperview()
        }
    }
    
    let backgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "bg")
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
            self.navigationController?.pushViewController(TabBarController(), animated: true)
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
        view.addSubviews([backgroundImageView, kakaoLoginButton, appleLoginButton])
        
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
    }
    
    // MARK: - Protocols
}
