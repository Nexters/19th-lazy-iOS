//
//  LoginViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/11.
//

import KakaoSDKAuth
import KakaoSDKUser
import UIKit

class LoginViewController: UIViewController {
    // MARK: - UIComponenets
    
    private lazy var kakaoLoginButton = UIButton().then {
        $0.setTitle("카카오 로그인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(kakaoLogin(_:)), for: .touchUpInside)
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
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { _, error in
                guard error != nil else { return }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { _, error in
                guard error != nil else { return }
            }
        }
    }
    
    // MARK: - Methods
    
    func setConstraints() {
        view.addSubviews([kakaoLoginButton])
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Protocols
}
