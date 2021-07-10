//
//  UIDevice+Extension.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/11.
//

import UIKit

extension UIDevice {
    var safeAreaInset: UIEdgeInsets {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows[0].safeAreaInsets
        } else {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
        }
    }
}
