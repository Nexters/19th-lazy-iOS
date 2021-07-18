//
//  DrawerView.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/18.
//

import UIKit

// FIXME: - 레이아웃 상수 고치기 (아직 미정)

class DrawerView: UIView {
    // MARK: - UIComponenets

    let handleView = UIView().then {
        $0.backgroundColor = .systemGray4
        $0.cornerRound(radius: 2.5)
    }
    
    // MARK: - Properties
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setConstraints()
    }
    
    // MARK: - Actions
    
    // MARK: - Methods
    
    func setView() {
        backgroundColor = .white
        cornerRound(radius: 20)
    }
    
    func setConstraints() {
        addSubviews([handleView])
        
        handleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalTo(5)
        }
    }
}
