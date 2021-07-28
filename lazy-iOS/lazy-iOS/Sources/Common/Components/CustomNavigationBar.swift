//
//  NavigationBar.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/25.
//

import UIKit

class CustomNavigationBar: UIView {
    // MARK: - UIComponents

    let titleLabel = UILabel().then {
        $0.font = .pretendard(type: .bold, size: 18)
        $0.textColor = UIColor(25, 31, 40, 1)
    }

    lazy var backButton = UIButton().then {
        $0.setImage(UIImage(named: "chevron.backward"), for: .normal)
        $0.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
    }

    lazy var cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = .pretendard(type: .regular, size: 18)
        $0.addTarget(self, action: #selector(didTapDismiss(_:)), for: .touchUpInside)
        $0.setTitleColor(.mainColor, for: .normal)
        $0.isHidden = true
    }

    // MARK: - Properties

    var navigationDelegate: NavigationDelegate?
    var modalDelegate: ModalDelegate?

    init(_ title: String, isHiddenRightButton: Bool = false) {
        super.init(frame: .zero)

        self.titleLabel.text = title
        self.backButton.isHidden = isHiddenRightButton

        self.setView()
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
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
        }

        self.backButton.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(48.0 / 375.0)
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

    func setView() {
        addSubviews([self.titleLabel, self.backButton, self.cancelButton])

        self.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(self.snp.width).multipliedBy(46.0 / 375.0)
        }
    }
}
