//
//  PopUpViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/21.
//

import UIKit

// TODO: - 안쓰기 각임..

class PopUpViewController: UIViewController {
    // MARK: - UIComponents

    let popUpView = UIView().then {
        $0.backgroundColor = .white
        $0.cornerRound(radius: 20)
    }

    let titleLabel = UILabel().then {
        $0.font = .pretendard(type: .bold, size: 18)
        $0.numberOfLines = 0
        $0.text = "습관은 최대 3개까지 관리할 수 있어요"
        $0.textAlignment = .center
        $0.textColor = .black
    }

    let commentLabel = UILabel().then {
        $0.font = .pretendard(type: .regular, size: 16)
        $0.text = "습관을 1개 이상 지워주세요"
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.textColor = .black
    }

    lazy var confirmButton = UIButton().then {
        $0.backgroundColor = UIColor(red: 80 / 255.0, green: 68.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
        $0.cornerRound(radius: 26)
        $0.setTitle("네", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .pretendard(type: .bold, size: 16)
    }

    lazy var closeButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
    }

    // MARK: - Initializer

    init(title: String, comment: String) {
        titleLabel.text = title
        commentLabel.text = comment

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        setConstraints()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != popUpView {
            dismiss(animated: true, completion: nil)
        }
    }

    // MARK: - Actions

    @objc
    func didTapCloseButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Method

    func setView() {
        view.layer.backgroundColor = UIColor.black.withAlphaComponent(0.5).cgColor
    }

    func setConstraints() {
        view.addSubview(popUpView)
        popUpView.addSubviews([titleLabel, commentLabel, confirmButton, closeButton])

        popUpView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(270.0 / 375.0)
            make.height.equalTo(popUpView.snp.width).multipliedBy(231.0 / 270.0)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
        }

        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-36)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(100.0 / 270.0)
            make.height.equalToSuperview().multipliedBy(52.0 / 231.0)
        }

        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(view.snp.width).multipliedBy(30.0 / 375.0)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
