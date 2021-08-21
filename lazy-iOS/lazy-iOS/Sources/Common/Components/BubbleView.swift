//
//  BubbleView.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/12.
//

import UIKit

// MARK: - Protocol

protocol BubbleGestureDelegate {
    func updateAnimator(velocity: CGPoint, item: UIView)
}

class BubbleView: UIControl {
    // MARK: - UIComponenets
    
    var iconImageView = UIImageView()
    
    // MARK: - Properties
    
    var gestureDelegate: BubbleGestureDelegate?
    var habit: Habit? {
        didSet {
            if let newHabit = habit {
                setIconImage(idx: newHabit.iconIdx)
            }
        }
    }
    
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        .ellipse
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    // MARK: - Actions

    @objc
    func handleBubbleView(_ gesture: UIPanGestureRecognizer) {
        guard let bubble = gesture.view else { return }

        switch gesture.state {
        case .ended:
            let velocity = gesture.velocity(in: superview)
            
            gestureDelegate?.updateAnimator(velocity: velocity, item: bubble)
        default:
            break
        }
    }

    // MARK: - Methods
    
    private func setView() {
        cornerRounds()
        iconImageView.cornerRounds()
        
        gestureRecognizers = [UIPanGestureRecognizer(target: self, action: #selector(handleBubbleView(_:)))]
    }
    
    func setIconImage(idx: Int) {
        iconImageView.image = UIImage(named: "habbit\(idx)")
    }
    
    private func setConstraints() {
        addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
