//
//  DetailHabitViewController+Layout.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/11.
//

import Foundation

extension DetailHabitViewController {
    func setConstraints() {
        navigationBar.addSubview(editButton)
        displayView.addSubviews([habitDayLabel, messageLabel])
        contentView.addSubviews([habitLabel, displayView, prevButton, calendarHeaderLabel, nextButton, calendar, giveUpButton])
        scrollView.addSubview(contentView)
        view.addSubviews([navigationBar, scrollView])
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.width.equalToSuperview()
        }
        
        editButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20 * DeviceConstants.widthRatio)
            make.centerY.equalToSuperview()
        }
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        habitLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(39)
            make.leading.trailing.equalToSuperview().inset(23 * DeviceConstants.widthRatio)
            make.height.equalTo(32 * DeviceConstants.heightRatio)
        }
        
        displayView.snp.makeConstraints { make in
            make.top.equalTo(habitLabel.snp.bottom).offset(11)
            make.width.equalToSuperview().multipliedBy(335.0 / 375.0)
            make.height.equalTo(displayView.snp.width).multipliedBy(161.0 / 335.0)
            make.centerX.equalToSuperview()
        }
        
        habitDayLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16 * DeviceConstants.heightRatio)
            make.leading.equalToSuperview().offset(20 * DeviceConstants.widthRatio)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.leading.equalTo(habitDayLabel.snp.leading)
            make.bottom.equalToSuperview().offset(-27 * DeviceConstants.heightRatio)
        }
        
        calendarHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(displayView.snp.bottom).offset(28)
            make.width.equalTo(42 * DeviceConstants.widthRatio)
            make.centerX.equalToSuperview()
        }
        
        prevButton.snp.makeConstraints { make in
            make.centerY.equalTo(calendarHeaderLabel.snp.centerY)
            make.trailing.equalTo(calendarHeaderLabel.snp.leading).offset(-20 * DeviceConstants.widthRatio)
        }
         
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(calendarHeaderLabel.snp.centerY)
            make.leading.equalTo(calendarHeaderLabel.snp.trailing).offset(20 * DeviceConstants.widthRatio)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(calendarHeaderLabel.snp.bottom).offset(26)
            make.leading.trailing.equalToSuperview().inset(15 * DeviceConstants.widthRatio)
            make.height.equalTo(230 * DeviceConstants.heightRatio)
        }
        
        giveUpButton.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-14)
        }
    }
}
