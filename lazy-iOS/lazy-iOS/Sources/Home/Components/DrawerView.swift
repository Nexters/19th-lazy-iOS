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
    func presentPreventAlert()
}

class DrawerView: UIView {
    // MARK: - UIComponenets

    let handleView = UIView().then {
        $0.backgroundColor = UIColor(228, 228, 228, 1)
        $0.cornerRound(radius: 2.5)
    }
    
    lazy var panGestureRecognizer = UIPanGestureRecognizer().then {
        $0.maximumNumberOfTouches = 2
        $0.minimumNumberOfTouches = 1
        $0.addTarget(self, action: #selector(handlePanGesture(_:)))
    }
    
    lazy var guideLabel = UILabel().then {
        $0.font = .pretendard(type: .bold, size: 20)
        $0.textColor = .gray8
    }
    
    lazy var plusButton = UIButton().then {
        $0.setImage(UIImage(named: "iconAdd"), for: .normal)
        $0.addTarget(self, action: #selector(didTapPlusButton(_:)), for: .touchUpInside)
    }
    
    lazy var habitTableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(HomeHabitTableViewCell.self, forCellReuseIdentifier: HomeHabitTableViewCell.identifier)
        $0.backgroundColor = .white
        $0.alwaysBounceVertical = false
        $0.separatorStyle = .none
        $0.estimatedRowHeight = 0
    }
    
    // MARK: - Properties
    
    var totalDelayedDate: Int = 0
    var drawerViewDelegate: DrawerViewDelegate?

    var tableViewContentHeight: CGFloat {
        habitTableView.layoutIfNeeded()
        return habitTableView.contentSize.height + UIComponentsConstants.homeDrawerCloseHeight + 12.0
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setView()
        setDelegate()
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
            if height - translationY > UIComponentsConstants.homeDrawerCloseHeight, height - translationY <= tableViewContentHeight {
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
        if HabitManager.shared.habitCount >= 3 {
            drawerViewDelegate?.presentPreventAlert()
        } else {
            drawerViewDelegate?.presentAddHabitView()
        }
    }
    
    // MARK: - Methods
    
    func setView() {
        backgroundColor = .white
        addGestureRecognizer(panGestureRecognizer)
    }
    
    func setDelegate() {
        HabitManager.shared.drawerHabitManagerDelegate = self
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
            make.width.height.equalTo(DeviceConstants.widthRatio * 24.0)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        habitTableView.snp.makeConstraints { make in
            make.top.equalTo(guideLabel.snp.bottom).offset(32)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    private func openDrawer() {
        snp.updateConstraints { make in
            make.height.equalTo(tableViewContentHeight)
        }
    }
    
    private func closeDrawer() {
        snp.updateConstraints { make in
            make.height.equalTo(UIComponentsConstants.homeDrawerCloseHeight)
        }
    }

    func springAnimation() {
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: { self.layoutIfNeeded() }, completion: nil)
    }
}

extension DrawerView: DrawerHabitManagerDelegate {
    func addHabits(_ habits: [Habit]) {
        habitTableView.reloadData()
        
        snp.updateConstraints { make in
            make.height.equalTo(tableViewContentHeight)
        }
        
        guideLabel.text = HabitManager.shared.delayDaysCount == 0 ? "모두 완료했어요" : "습관이 \(HabitManager.shared.delayDaysCount)일 쌓였어요"
    }
}
