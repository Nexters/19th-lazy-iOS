//
//  DiviceConstants.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/19.
//

import UIKit

struct DiviceConstants {
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let widthRatio = screenWidth / 375.0
    static let heightRatio = screenHeight / 812.0
    static let safeAreaInset = UIApplication.shared.windows.first?.safeAreaInsets
}
