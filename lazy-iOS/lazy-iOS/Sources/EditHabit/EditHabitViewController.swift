//
//  AddHabitViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/22.
//

import UIKit

enum habitMode: String {
    case add = "새로운 습관"
    case edit = "습관 편집"
}

class EditHabitViewController: UIViewController {
    // MARK: - UIComponenets
    
    let navigationBar = CustomNavigationBar("", state: .modal)
    
    lazy var habitSettingView = LabeledRoundedView(state: .setHabit, habitNameTextField)
    lazy var habitNameTextField = UITextField().then {
        let placeholder = "습관을 써주세요"
        $0.placeholder = placeholder
        $0.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray6])
        $0.font = .pretendard(type: .medium, size: 18)
        $0.textColor = .gray8
    }
    
    lazy var dayOfWeekSettingView = LabeledRoundedView(state: .dayOfTheWeek, dayOfWeekCollectionView)
    lazy var dayOfWeekCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
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
        label.textColor = UIColor.gray8
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
        $0.onTintColor = .mainPurple
        $0.addTarget(self, action: #selector(didTapSwitch(_:)), for: .valueChanged)
    }
    
    lazy var alarmTimeSettingView = RoundedView()
    let alarmTimeLabel = UILabel().then {
        $0.text = "알림시간"
        $0.textColor = .gray6
        $0.font = UIFont.pretendard(type: .medium, size: 18)
    }

    lazy var alarmTimeButton = UIButton().then {
        $0.addTarget(self, action: #selector(didTapTimeButton(_:)), for: .touchUpInside)
        $0.setTitle("시간 선택", for: .normal)
    }

    let alarmTimePicker = UIDatePicker().then {
        $0.datePickerMode = .time
        if #available(iOS 13.4, *) {
            $0.preferredDatePickerStyle = .wheels
        }
        $0.locale = Locale(identifier: "ko")
    }

    lazy var saveButton = UIButton().then {
        $0.setTitle("저장", for: .normal)
        $0.titleLabel?.font = .pretendard(type: .medium, size: 18)
        $0.setTitleColor(.lightGray, for: .disabled)
        $0.setTitleColor(.mainPurple, for: .normal)
//        $0.isEnabled = false
        $0.addTarget(self, action: #selector(didTapSaveButton(_:)), for: .touchUpInside)
    }

    // MARK: - Properties
    
    var weeks = ["일", "월", "화", "수", "목", "금", "토"]
    var colors = [UIColor.icon1, UIColor.icon2, UIColor.icon3, UIColor.icon4, UIColor.icon5, UIColor.icon6, UIColor.icon7, UIColor.icon8]
    var isFirst: Bool = true
    var hasChanges: Bool = true
    
    var isOnAlarmSwitch = false {
        willSet(newValue) {
            if newValue {
                alarmTimeButton.isUserInteractionEnabled = true
                alarmTimeButton.setTitleColor(.gray7, for: .normal)
                alarmTimeLabel.textColor = .gray8
            } else {
                alarmTimeButton.isUserInteractionEnabled = false
                alarmTimeButton.setTitleColor(.gray5, for: .normal)
                alarmTimeLabel.textColor = .gray6
            }
        }
    }
    
    // MARK: - Initializer
    
    init(mode: habitMode, habit: Data? = nil) {
        navigationBar.titleLabel.text = mode.rawValue
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setDelegate()
        setConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        isModalInPresentation = hasChanges
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
    
    @objc
    func didTapSaveButton(_ sender: UIButton) {
        if let title = habitNameTextField.text,
           let icon = iconCollectionView.indexPathsForSelectedItems?.first?.row,
           let dayOfWeeks = dayOfWeekCollectionView.indexPathsForSelectedItems,
           let alarmTime = alarmTimeButton.titleLabel?.text
        {
            print("title:", title)
            print("icon:", icon + 1)
            print("dayOfWeeks:", dayOfWeeks)
            print("isAlarm:", isOnAlarmSwitch)
            print("alarmTime:", alarmTimePicker.date, "\(alarmTime)")
            
            let idx = HabitManager.shared.habitCount
            let days = dayOfWeeks.map { $0.row + 1 }
            let habit = Habit(idx: idx, iconIdx: icon + 1, name: title, frequency: 1, delayDay: 1, registrationDate: Date(), isAlarm: false, repeatDays: days, completion: false)

            HabitManager.shared.appendHabits([habit])
            dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .white
        isOnAlarmSwitch = false
    }
    
    func setDelegate() {
        presentationController?.delegate = self
        navigationBar.modalDelegate = self
        habitNameTextField.delegate = self
    }
    
    func confirmCancel() {
        let alert = UIAlertController(title: "습관 작성을 그만하시겠어요?", message: "작성한 내용은 저장되지 않아요", preferredStyle: .alert)
        
        let continueAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(continueAction)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - ModalDelegate

extension EditHabitViewController: ModalDelegate {
    func dismiss() {
        if hasChanges {
            confirmCancel()
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - UIAdaptivePresentationControllerDelegate

extension EditHabitViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        confirmCancel()
    }
}
