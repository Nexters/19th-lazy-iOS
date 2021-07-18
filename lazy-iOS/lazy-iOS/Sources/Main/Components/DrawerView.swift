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
        $0.backgroundColor = .lightGray
        $0.cornerRound(radius: 2.5)
    }
    
    lazy var panGestureRecognizer = UIPanGestureRecognizer().then {
        $0.maximumNumberOfTouches = 2
        $0.minimumNumberOfTouches = 1
        $0.addTarget(self, action: #selector(handlePanGesture(_:)))
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
        super.layoutSubviews()
        
        setConstraints()
    }
    
    // MARK: - Actions
    
    @objc func handlePanGesture(_ gestrue: UIPanGestureRecognizer) {
        let translationY = gestrue.translation(in: self).y
        let height = bounds.height
        let velocity = gestrue.velocity(in: self)
        
        switch gestrue.state {
        case .ended:
            if velocity.y > 0 {
                print("close")
                hideDrawer()
            } else {
                print("show")
                showDrawer()
            }
        case .changed:
            if height - translationY > 100, height - translationY <= 300 {
                snp.updateConstraints { make in
                    print("update", height - translationY)
                    make.height.equalTo(height - translationY)
                }
                
                panGestureRecognizer.setTranslation(.zero, in: self)
            }
        default: break
        }
    }
    
    // MARK: - Methods
    
    func setView() {
        backgroundColor = .white
        cornerRound(radius: 20)
        
        addGestureRecognizer(panGestureRecognizer)
    }
    
    func setConstraints() {
        addSubviews([handleView])
        
        handleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalTo(5)
        }
    }
    
    func showDrawer() {
        snp.updateConstraints { make in
            make.height.equalTo(300)
        }
    }
    
    func hideDrawer() {
        snp.updateConstraints { make in
            make.height.equalTo(100)
        }
    }
}
