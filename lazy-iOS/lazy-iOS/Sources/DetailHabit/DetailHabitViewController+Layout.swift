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
        contentView.addSubviews([habitsCollectionView, displayView, prevButton, calenderHeaderLabel, nextButton, calendar, giveUpButton])
        scrollView.addSubview(contentView)
        view.addSubviews([navigationBar, scrollView])
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.width.equalToSuperview()
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
            make.bottom.equalToSuperview().offset(-34 * DeviceConstants.heightRatio)
        }
        
        calenderHeaderLabel.snp.makeConstraints { make in
            make.top.equalTo(displayView.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        
        prevButton.snp.makeConstraints { make in
            make.centerY.equalTo(calenderHeaderLabel.snp.centerY)
            make.trailing.equalTo(calenderHeaderLabel.snp.leading).offset(-20 * DeviceConstants.widthRatio)
        }
         
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(calenderHeaderLabel.snp.centerY)
            make.leading.equalTo(calenderHeaderLabel.snp.trailing).offset(20 * DeviceConstants.widthRatio)
        }
        
        calendar.snp.makeConstraints { make in
            make.top.equalTo(calenderHeaderLabel.snp.bottom).offset(26)
            make.leading.trailing.equalToSuperview().inset(18 * DeviceConstants.widthRatio)
            make.height.equalTo(250 * DeviceConstants.heightRatio)
        }
        
        giveUpButton.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }
    }
}
