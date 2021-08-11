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
        displayView.addSubviews([habitLabel, habitDayLabel, messageLabel])
        contentView.addSubviews([habitsCollectionView, displayView, prevButton, calendarHeaderLabel, nextButton, calendar, giveUpButton])
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
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        habitsCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(38)
            make.leading.trailing.equalToSuperview().inset(20 * DeviceConstants.widthRatio)
            make.height.equalTo(32 * DeviceConstants.heightRatio)
        }
        
        displayView.snp.makeConstraints { make in
            make.top.equalTo(habitsCollectionView.snp.bottom).offset(16)
            make.width.equalToSuperview().multipliedBy(335.0 / 375.0)
            make.height.equalTo(displayView.snp.width).multipliedBy(203.0 / 335.0)
            make.centerX.equalToSuperview()
        }
        
        habitLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28 * DeviceConstants.heightRatio)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        habitDayLabel.snp.makeConstraints { make in
            make.top.equalTo(habitLabel.snp.bottom)
            make.leading.equalTo(habitLabel.snp.leading)
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
            make.top.equalTo(calendar.snp.bottom).offset(36)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}
