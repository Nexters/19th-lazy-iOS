//
//  NSMutableAttributedString+Extension.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/10.
//

import UIKit

extension NSMutableAttributedString {
    func addAttributeString(str: String, size: CGFloat, type: PretendardType = .medium, color: UIColor) -> NSMutableAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.pretendard(type: type, size: size), .foregroundColor: color]
        self.append(NSAttributedString(string: str, attributes: attributes))
        return self
    }
}
