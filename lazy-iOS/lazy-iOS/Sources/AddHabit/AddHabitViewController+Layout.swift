//
//  AddHabitViewController+Layout.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/28.
//

import Foundation

extension AddHabitViewController {
    func setConstraints() {
        view.addSubviews([navigationBar, habitSettingView, dayOfWeekSettingView, iconSettingView, alarmSettingView, alarmTimeSettingView])
        navigationBar.addSubview(saveButton)
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18 * DeviceConstants.heightRatio)
            make.leading.trailing.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20 * DeviceConstants.widthRatio)
            make.centerY.equalToSuperview()
        }

        habitSettingView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(58 * DeviceConstants.heightRatio)
            make.width.equalToSuperview().multipliedBy(335.0 / 375.0)
            make.centerX.equalToSuperview()
        }
        
        iconSettingView.snp.makeConstraints { make in
            make.top.equalTo(habitSettingView.snp.bottom).offset(10 * DeviceConstants.heightRatio)
            make.leading.trailing.equalTo(habitSettingView)
            make.height.equalTo(iconSettingView.snp.width).multipliedBy(70.0 / 335.0)
            make.centerX.equalToSuperview()
        }
        
        iconCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(14)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-14)
        }
        
        dayOfWeekSettingView.snp.makeConstraints { make in
            make.top.equalTo(iconSettingView.snp.bottom).offset(44)
            make.leading.trailing.equalTo(habitSettingView)
            make.height.equalTo(iconSettingView.snp.width).multipliedBy(92.0 / 335.0)
            make.centerX.equalToSuperview()
        }
        
        alarmSettingView.snp.makeConstraints { make in
            make.top.equalTo(dayOfWeekSettingView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(habitSettingView)
            make.centerX.equalToSuperview()
        }
        
        alarmTimeSettingView.snp.makeConstraints { make in
            make.top.equalTo(alarmSettingView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(habitSettingView)
            make.centerX.equalToSuperview()
        }
        
        alarmTimeSettingView.addSubviews([alarmTimeLabel, alarmTimeButton])
        alarmTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.bottom.equalToSuperview().inset(19)
        }
        
        alarmTimeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(alarmTimeLabel.snp.centerY)
        }
    }
}
