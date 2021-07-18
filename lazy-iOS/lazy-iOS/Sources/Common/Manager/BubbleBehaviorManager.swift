//
//  BubbleBehavior.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/18.
//

import Then
import UIKit

class BubbleBehaviorManager: UIDynamicBehavior {
    // MARK: - Properties

    lazy var gravityBehavior = UIGravityBehavior()

    lazy var collisionBehavior = UICollisionBehavior().then {
        $0.translatesReferenceBoundsIntoBoundary = true
    }

    lazy var dynamicItemBehavior = UIDynamicItemBehavior().then {
        $0.allowsRotation = true
        $0.elasticity = 0.5 /// 탄성
        $0.friction = 0.2 /// 마찰
        $0.resistance = -0.3 /// 저항
    }

    override init() {
        super.init()

        addChildBehavior(gravityBehavior)
        addChildBehavior(collisionBehavior)
        addChildBehavior(dynamicItemBehavior)

        updateBubblePosition()
    }

    // MARK: - Method

    func addBubble(_ bubble: UIView) {
        dynamicAnimator?.referenceView?.addSubview(bubble)

        gravityBehavior.addItem(bubble)
        collisionBehavior.addItem(bubble)
        dynamicItemBehavior.addItem(bubble)
    }

    func updateBubblePosition() {
        if AppDelegate.motionManager.isAccelerometerAvailable {
            AppDelegate.motionManager.startAccelerometerUpdates(to: OperationQueue.main) { data, _ in
                self.gravityBehavior.gravityDirection = CGVector(dx: data?.acceleration.x ?? 0, dy: -(data?.acceleration.y ?? 0))
            }
        }
    }
}
