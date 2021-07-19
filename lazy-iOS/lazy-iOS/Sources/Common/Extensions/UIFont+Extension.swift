//
//  UIFont+Extension.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/20.
//

import UIKit

extension UIFont {
    class func pretendard(type: PretendardType, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.name, size: size) else { return UIFont() }

        return font
    }
}

enum PretendardType: String {
    case regular = "Regular"
    case medium = "Medium"
    case bold = "Bold"
    case extraBold = "ExtraBold"

    var name: String {
        "Pretendard-" + self.rawValue
    }
}
