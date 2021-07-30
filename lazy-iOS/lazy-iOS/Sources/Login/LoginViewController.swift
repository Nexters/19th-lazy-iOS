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
        $0.setTitle("카카오 로그인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(kakaoLogin(_:)), for: .touchUpInside)
    }
    
    private lazy var appleLoginButton = UIButton().then {
        $0.setTitle("애플 로그인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
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
    
    // MARK: - Actions
    
    @objc
    func kakaoLogin(_ sender: UIButton) {
        SignManager.shared.requestLoginWithKakao {
            self.navigationController?.pushViewController(MainViewController(), animated: true)
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
            make.bottom.equalTo(appleLoginButton.snp.top).offset(-12)
            make.height.equalTo(60)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.height.equalTo(60)
        }
    }
    
    // MARK: - Protocols
}
