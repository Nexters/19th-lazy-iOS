//
//  UIView+Extension.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/11.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }

    func cornerRounds() {
        self.layer.cornerRadius = self.layer.frame.height / 2
        self.layer.masksToBounds = true
    }

    func cornerRound(radius: CGFloat, direct: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = direct
        self.layer.masksToBounds = true
    }

    func setShadow(radius: CGFloat, offset: CGSize, opacity: Float, color: UIColor = .black) {
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }

    func setGradient(color1: UIColor, color2: UIColor) {
        layer.sublayers?.removeAll()

        let gradient = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
