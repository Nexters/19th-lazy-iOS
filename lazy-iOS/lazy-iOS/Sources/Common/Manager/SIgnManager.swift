//
//  SIgnManager.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/11.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser

class SignManager: NSObject {
    static let shared = SignManager()

    func requestLoginWithKakao(completion: @escaping () -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { _, error in
                guard error == nil else { return }
            }

            completion()
        } else {
            UserApi.shared.loginWithKakaoAccount { _, error in
                guard error == nil else { return }
            }

            completion()
        }
    }
}
