//
//  NavigationBar.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/25.
//

import UIKit

class NavigationBar: UIView {
    // MARK: - UIComponents

    let title = UILabel().then {
        $0.font = .pretendard(type: .bold, size: 18)
        $0.textColor = UIColor(10, 10, 10, 10)
    }
}
