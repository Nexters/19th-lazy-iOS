//
//  AddHabitViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/22.
//

import UIKit

class AddHabitViewController: UIViewController {
    // MARK: - UIComponenets
    
    let navigationBar = CustomNavigationBar("새로운 습관", state: .modal)
    
    lazy var habitSettingView = LabeledRoundedView(state: .setHabit, habitNameTextField)
    lazy var habitNameTextField = UITextField().then {
        $0.placeholder = "습관을 써주세요"
        $0.font = .pretendard(type: .medium, size: 18)
    }
    
    lazy var dayOfWeekSettingView = LabeledRoundedView(state: .dayOfTheWeek, dayOfWeekCollectionView)
    lazy var dayOfWeekCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        $0.setCollectionViewLayout(layout, animated: true)
        $0.allowsMultipleSelection = true
        $0.dataSource = self
        $0.delegate = self
        $0.automaticallyAdjustsScrollIndicatorInsets = false
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        
        $0.register(cell: DayOfWeekCollectionViewCell.self)
    }
    
    lazy var iconSettingView = RoundedView().then {
        $0.addSubview(iconCollectionView)
    }

    lazy var iconCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        $0.setCollectionViewLayout(layout, animated: true)
        $0.dataSource = self
        $0.delegate = self
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        
        $0.register(cell: IconCollectionViewCell.self)
    }
    
    // FIXME: - alarm - time 이거 줄일 수 .. ?
    lazy var alarmSettingView = RoundedView().then {
        let label = UILabel()
        label.text = "알림"
        label.font = UIFont.pretendard(type: .medium, size: 18)
        
        $0.addSubviews([label, alarmSwitch])
        label.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.bottom.equalToSuperview().inset(19)
        }
        
        alarmSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(label.snp.centerY)
        }
    }

    lazy var alarmSwitch = UISwitch().then {
        $0.onTintColor = .mainColor
        $0.addTarget(self, action: #selector(didTapSwitch(_:)), for: .valueChanged)
    }
    
    lazy var alarmTimeSettingView = RoundedView()
    let alarmTimeLabel = UILabel().then {
        $0.text = "알림시간"
        $0.font = UIFont.pretendard(type: .medium, size: 18)
    }

    lazy var alarmTimeButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapTimeButton(_:)), for: .touchUpInside)
        $0.setTitle("시간 선택", for: .normal)
    }

    let alarmTimePicker = UIDatePicker().then {
        $0.datePickerMode = .time
        $0.preferredDatePickerStyle = .wheels
        $0.locale = Locale(identifier: "ko")
    }
    
    lazy var confirmButton = UIButton().then {
        $0.setTitle("추가하기 ", for: .normal)
        $0.titleLabel?.font = .pretendard(type: .bold, size: 16)
        $0.backgroundColor = .mainColor
        $0.addTarget(self, action: #selector(didTapConfirmButton(_:)), for: .touchUpInside)
    }

    // MARK: - Properties
    
    var weeks = ["일", "월", "화", "수", "목", "금", "토"]
    var colors = [UIColor.icon1, UIColor.icon2, UIColor.icon3, UIColor.icon4, UIColor.icon5, UIColor.icon6, UIColor.icon7, UIColor.icon8]
    var isFirst: Bool = true
    
    var isOnAlarmSwitch = false {
        willSet(newValue) {
            if newValue {
                alarmTimeButton.isUserInteractionEnabled = true
                alarmTimeButton.setTitleColor(.textSecondary, for: .normal)
                alarmTimeLabel.textColor = .textPrimary
            } else {
                alarmTimeButton.isUserInteractionEnabled = false
                alarmTimeButton.setTitleColor(.textCaption, for: .normal)
                alarmTimeLabel.textColor = .textCaption
            }
        }
    }
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        confirmButton.cornerRounds()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Actions
    
    @objc
    func didTapTimeButton(_ sender: UIButton) {
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let viewDatePicker = UIView()
        
        viewDatePicker.addSubview(alarmTimePicker)
        actionSheet.view.addSubview(viewDatePicker)
        
        viewDatePicker.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(61)
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(200)
        }
        
        alarmTimePicker.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        actionSheet.view.snp.makeConstraints { make in
            make.height.equalTo(400)
        }
        
        let messageAttributes = [NSAttributedString.Key.font: UIFont.pretendard(type: .medium, size: 18)]
        let messageString = NSAttributedString(string: "시간 선택", attributes: messageAttributes)
        actionSheet.setValue(messageString, forKey: "attributedMessage")
        
        let selectAction = UIAlertAction(title: "확인", style: .default, handler: { _ in
            let selectedDate = Date().dateToString(format: "a hh:mm", date: self.alarmTimePicker.date)
            
            print("Selected Date: \(selectedDate)")
            self.alarmTimeButton.isSelected = true
            self.alarmTimeButton.setTitle(selectedDate, for: .normal)
        })
        let cancelAction = UIAlertAction(title: "취소 ", style: .cancel, handler: nil)

        actionSheet.addAction(selectAction)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true)
    }
    
    @objc
    func didTapSwitch(_ sender: UISwitch) {
        isOnAlarmSwitch.toggle()
    }
    
    @objc
    func didTapConfirmButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .white
        isOnAlarmSwitch = false
    }
}

// MARK: - Protocols
