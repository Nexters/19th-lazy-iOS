//
//  UIColor+Extension.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/24.
//

import UIKit

extension UIColor {
    convenience init(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) {
        self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }

    @nonobjc static var icon1: UIColor { .init(0, 99, 196, 1) }
    @nonobjc static var icon2: UIColor { .init(255, 211, 53, 1) }
    @nonobjc static var icon3: UIColor { .init(30, 215, 96, 1) }
    @nonobjc static var icon4: UIColor { .init(255, 98, 138, 1) }
    @nonobjc static var icon5: UIColor { .init(299, 299, 299, 1) }
    @nonobjc static var icon6: UIColor { .init(58, 171, 255, 1) }
    @nonobjc static var icon7: UIColor { .init(27, 70, 134, 1) }
    @nonobjc static var icon8: UIColor { .init(255, 88, 88, 1) }

    @nonobjc static var mainColor: UIColor { .init(80, 68, 255, 1) }
    @nonobjc static var textPrimary: UIColor { .init(25, 31, 40, 1) }
    @nonobjc static var textSecondary: UIColor { .init(121, 126, 134, 1) }
    @nonobjc static var textCaption: UIColor { .init(161, 167, 175, 1) }
}
