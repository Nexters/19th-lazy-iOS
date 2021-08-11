//
//  NavigationBar.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/25.
//

import UIKit

enum NavigationMode {
    case navigation
    case modal
    case none
}

class CustomNavigationBar: UIView {
    // MARK: - UIComponents

    let titleLabel = UILabel().then {
        $0.font = .pretendard(type: .semiBold, size: 18)
        $0.textColor = UIColor(25, 31, 40, 1)
    }

    lazy var backButton = UIButton().then {
        $0.setImage(UIImage(named: "iconClose"), for: .normal)
        $0.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
    }

    lazy var cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = .pretendard(type: .regular, size: 18)
        $0.setTitleColor(.mainPurple, for: .normal)
        $0.addTarget(self, action: #selector(didTapDismiss(_:)), for: .touchUpInside)
    }

    // MARK: - Properties

    var navigationDelegate: NavigationDelegate?
    var modalDelegate: ModalDelegate?

    init(_ title: String, state: NavigationMode) {
        super.init(frame: .zero)

        self.titleLabel.text = title

        self.setView(state)
        self.setConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        self.cancelButton.snp.makeConstraints { make in
            make.leading.equalTo(20 * DeviceConstants.widthRatio)
            make.centerY.equalToSuperview()
        }

        self.backButton.snp.makeConstraints { make in
            make.leading.equalTo(20 * DeviceConstants.widthRatio)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(30.0 / 375.0)
            make.height.equalTo(backButton.snp.width)
        }
    }

    @objc
    func didTapBackButton(_ sender: UIButton) {
        self.navigationDelegate?.pop()
    }

    @objc
    func didTapDismiss(_ sender: UIButton) {
        self.modalDelegate?.dismiss()
    }

    func setView(_ state: NavigationMode) {
        switch state {
        case .navigation:
            self.cancelButton.isHidden = true
        case .modal:
            self.backButton.isHidden = true
        case .none:
            self.backButton.isHidden = true
            self.cancelButton.isHidden = true
        }
    }

    func setConstraints() {
        addSubviews([self.titleLabel, self.backButton, self.cancelButton])

        self.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(self.snp.width).multipliedBy(46.0 / 375.0)
        }
    }
}
