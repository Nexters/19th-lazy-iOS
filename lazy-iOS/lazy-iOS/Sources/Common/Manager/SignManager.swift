//
//  SIgnManager.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/11.
//

import AuthenticationServices
import Foundation
import KakaoSDKAuth
import KakaoSDKUser

class SignManager: NSObject {
    static let shared = SignManager()

    // MARK: - Properties

    typealias Completion = () -> Void
    var completion: Completion?

    // MARK: - Initializer

    override init() {
        super.init()
    }

    // MARK: - Kakao

    func requestLoginWithKakao(completion: @escaping Completion) {
        self.completion = completion

        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { _, error in
                guard error != nil else { return }
            }

            self.completion?()
        } else {
            UserApi.shared.loginWithKakaoAccount { _, error in
                guard error != nil else { return }
            }

            self.completion?()
        }
    }

    // MARK: - Apple

    func requestLoginWithApple(completion: @escaping Completion) {
        self.completion = completion

        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK: - ASAuthorizationControllerDelegate

extension SignManager: ASAuthorizationControllerDelegate {}

// MARK: - ASAuthorizationControllerPresentationContextProviding

extension SignManager: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })!
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user // userIdentifier
            let userName = appleIDCredential.fullName // fullName
            let userEmail = appleIDCredential.email // email

            print(userIdentifier)
            print(userName)
            print(userEmail)
            print(String(data: appleIDCredential.authorizationCode ?? Data(), encoding: .utf8))
            print(String(data: appleIDCredential.identityToken ?? Data(), encoding: .utf8))
            print(appleIDCredential.authorizationCode)
        }

        self.completion?()
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(#function, error)
    }
}
