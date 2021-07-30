//
//  UILabel+Extension.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/31.
//

import UIKit

extension UILabel {
    func lineSpacing(spacing: CGFloat) {
        if let text = self.text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()

            style.lineSpacing = spacing

            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
            self.attributedText = attributeString
        }
    }
}
