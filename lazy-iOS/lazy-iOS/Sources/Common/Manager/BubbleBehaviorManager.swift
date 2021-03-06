//
//  BubbleBehavior.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/18.
//

import Then
import UIKit

class BubbleBehaviorManager: UIDynamicBehavior {
    static let shared = BubbleBehaviorManager()

    // MARK: - Properties

    lazy var gravityBehavior = UIGravityBehavior().then {
        $0.gravityDirection = CGVector(dx: 0, dy: 200)
    }

    lazy var collisionBehavior = UICollisionBehavior().then {
        $0.translatesReferenceBoundsIntoBoundary = true
        $0.collisionDelegate = self
    }

    lazy var dynamicItemBehavior = UIDynamicItemBehavior().then {
        $0.allowsRotation = true
        $0.elasticity = 0.8 /// 탄성
        $0.friction = 0.5 /// 마찰
        $0.resistance = 1.0 /// 저항
    }

    let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)

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

    func removeBubble(_ bubble: UIView) {
        gravityBehavior.removeItem(bubble)
        collisionBehavior.removeItem(bubble)
        dynamicItemBehavior.removeItem(bubble)
    }

    func updateBubblePosition() {
        if AppDelegate.motionManager.isAccelerometerAvailable {
            AppDelegate.motionManager.startAccelerometerUpdates(to: OperationQueue.main) { data, _ in
                self.gravityBehavior.gravityDirection = CGVector(dx: data?.acceleration.x ?? 0, dy: -(data?.acceleration.y ?? 0))
            }
        }
    }

    func stopBubble() {
        AppDelegate.motionManager.stopAccelerometerUpdates()
    }

    func removeAllBehaviors() {
        removeChildBehavior(gravityBehavior)
        removeChildBehavior(dynamicItemBehavior)
        removeChildBehavior(collisionBehavior)
    }

    func addAllBehaviors() {
        addChildBehavior(gravityBehavior)
        addChildBehavior(collisionBehavior)
        addChildBehavior(dynamicItemBehavior)
    }
}

extension BubbleBehaviorManager: UICollisionBehaviorDelegate {
    func collisionBehavior(_ behavior: UICollisionBehavior,
                           endedContactFor item: UIDynamicItem,
                           withBoundaryIdentifier identifier: NSCopying?)
    {
        feedbackGenerator.impactOccurred()
    }
}
