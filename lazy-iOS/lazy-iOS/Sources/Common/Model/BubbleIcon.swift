//
//  BubbleIcon.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/21.
//

import UIKit

enum BubbleIcon: Int, CaseIterable {
    case habit1 = 1
    case habit2 = 2
    case habit3 = 3
    case habit4 = 4
    case habit5 = 5

    static var iconCount: Int {
        BubbleIcon.allCases.count
    }

    var iconImage: UIImage {
        switch self {
        case .habit1:
            return UIImage(named: "habbit1") ?? UIImage()
        case .habit2:
            return UIImage(named: "habbit2") ?? UIImage()
        case .habit3:
            return UIImage(named: "habbit3") ?? UIImage()
        case .habit4:
            return UIImage(named: "habbit4") ?? UIImage()
        case .habit5:
            return UIImage(named: "habbit5") ?? UIImage()
        }
    }
}
