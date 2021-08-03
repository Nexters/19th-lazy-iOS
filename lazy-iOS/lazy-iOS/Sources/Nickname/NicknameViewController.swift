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
    
    let guideLabel = UILabel().then {
        $0.text = "뭐라고 부르면 될까요?"
        $0.textColor = .gray1
        $0.font = .pretendard(type: .medium, size: 28)
    }
    
    let roundedView = RoundedView()
    
    lazy var nicknameTextField = UITextField().then {
        $0.font = .pretendard(type: .medium, size: 18)
        $0.placeholder = "닉네임을 입력하세요"
        $0.textColor = .gray1
        $0.autocorrectionType = .no
        $0.addTarget(self, action: #selector(editTextField(_:)), for: .editingChanged)
        $0.delegate = self
    }
    
    lazy var confirmButton = RoundedButton(style: .purple).then {
        $0.setTitle("회원가입 끝!", for: .normal)
        $0.isEnabled = false
        $0.addTarget(self, action: #selector(didTapConfirmButton(_:)), for: .touchUpInside)
    }
    
    let textFieldIcon = UIImageView().then {
        $0.isHidden = false
        $0.contentMode = .scaleAspectFit
//        $0.image = UIImage(named: "iconValid")
        $0.image = UIImage(named: "iconInvalid")
    }
    
    // MARK: - Properties
    
    let maximumNumberOfChar = 10
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nicknameTextField.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @objc
    func editTextField(_ sender: UITextField) {
        if let text = sender.text {
            if text.count == 0 {
                confirmButton.isEnabled = false
            } else {
                confirmButton.isEnabled = true
            }
            
            if text.count >= maximumNumberOfChar {
                let index = text.index(text.startIndex, offsetBy: maximumNumberOfChar)
                let newString = text[text.startIndex ..< index]
                nicknameTextField.text = String(newString)
            }
        }
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height + 30
            
            confirmButton.snp.updateConstraints { make in
                make.bottom.equalToSuperview().offset(-keyboardHeight)
            }
            
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        confirmButton.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    func didTapConfirmButton(_ sender: UIButton) {
        /// 닉네임 분기 처리 후 이동
        let typeVC = HabitTypeViewController()
        
        navigationController?.pushViewController(typeVC, animated: true)
    }
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .white
    }
    
    func setConstraints() {
        view.addSubviews([guideLabel, roundedView, confirmButton])
        roundedView.addSubviews([nicknameTextField, textFieldIcon])
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(132 * DeviceConstants.heightRatio)
            make.leading.equalTo(roundedView.snp.leading)
        }
        
        roundedView.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(40 * DeviceConstants.heightRatio)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(335.0 / 375.0)
            make.height.equalTo(nicknameTextField.snp.width).multipliedBy(60.0 / 335.0)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        textFieldIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(nicknameTextField.snp.height)
            make.centerY.equalToSuperview()
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30 * DeviceConstants.heightRatio)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(320.0 / 375.0)
            make.height.equalTo(confirmButton.snp.width).multipliedBy(60.0 / 320.0)
        }
    }
}

// MARK: - UITextFieldDelegate

extension NicknameViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}
