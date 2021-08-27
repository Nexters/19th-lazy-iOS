//
//  IconCalendarCell.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/27.
//

import FSCalendar
import UIKit

class IconCalendarCell: FSCalendarCell {
    let iconImage = UIImageView()

    override init!(frame: CGRect) {
        super.init(frame: frame)

        contentView.insertSubview(iconImage, at: 0)
    }

    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        iconImage.frame = CGRect(origin: .zero, size: CGSize(width: titleLabel.frame.height, height: titleLabel.frame.height))
        iconImage.center.x = contentView.center.x
        iconImage.cornerRounds()
    }

    func setIconImage(idx: Int) {
        iconImage.image = UIImage(named: "habbit\(idx)")
    }
}
