//
//  DrawerView.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/18.
//

import UIKit

// FIXME: - 레이아웃 상수 고치기 (아직 미정)

protocol DrawerViewDelegate {
    func presentAddHabitView()
}

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
    
    lazy var guideLabel = UILabel().then {
        $0.text = "총 \(self.totalDelayedDate)일 밀렸어요~!"
        $0.font = .pretendard(type: .bold, size: 20)
        $0.textColor = .black
    }
    
    lazy var plusButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector(didTapPlusButton(_:)), for: .touchUpInside)
    }
    
    lazy var habitTableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(HomeHabitTableViewCell.self, forCellReuseIdentifier: HomeHabitTableViewCell.identifier)
        $0.backgroundColor = .white
        $0.alwaysBounceVertical = false
        $0.separatorStyle = .none
        $0.allowsSelection = false
    }
    
    // MARK: - Properties
    
    var totalDelayedDate: Int = 0
    var drawerViewDelegate: DrawerViewDelegate?
    var isOpen: Bool = false
    
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
        cornerRound(radius: 20, direct: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    // MARK: - Actions
    
    @objc func handlePanGesture(_ gestrue: UIPanGestureRecognizer) {
        let translationY = gestrue.translation(in: self).y
        let height = bounds.height
        let velocity = gestrue.velocity(in: self)
        let tableViewHeight = habitTableView.contentSize.height + UIComponentsConstants.homeDrawerCloseHeight + 12.0
        
        switch gestrue.state {
        case .ended:
            /// velocity.y > 0 : 아래로 내릴 때
            /// velocity.y < 0: 위로 올릴 때
            if velocity.y > 0 {
                closeDrawer()
            } else {
                openDrawer()
            }
            
            springAnimation()
        case .changed:
            if height - translationY > UIComponentsConstants.homeDrawerCloseHeight, height - translationY <= tableViewHeight {
                snp.updateConstraints { make in
                    make.height.equalTo(height - translationY)
                }
                
                panGestureRecognizer.setTranslation(.zero, in: self)
            }
        default: break
        }
    }
    
    @objc
    func didTapPlusButton(_ sender: UIButton) {
        drawerViewDelegate?.presentAddHabitView()
    }
    
    // MARK: - Methods
    
    func setView() {
        backgroundColor = .white
        addGestureRecognizer(panGestureRecognizer)
    }
    
    func setConstraints() {
        addSubviews([handleView, guideLabel, plusButton, habitTableView])

        handleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalTo(4)
        }

        guideLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(38)
            make.leading.equalToSuperview().offset(20)
        }

        plusButton.snp.makeConstraints { make in
            make.centerY.equalTo(guideLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        habitTableView.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(32)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    func openDrawer() {
        snp.updateConstraints { make in
            make.height.equalTo(self.habitTableView.contentSize.height + UIComponentsConstants.homeDrawerCloseHeight + 12.0)
        }
    }
    
    func closeDrawer() {
        snp.updateConstraints { make in
            make.height.equalTo(UIComponentsConstants.homeDrawerCloseHeight)
        }
    }

    func springAnimation() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: { self.layoutIfNeeded() }, completion: nil)
    }
}
