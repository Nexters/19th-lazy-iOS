//
//  DetailHabitViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/05.
//

import FSCalendar
import UIKit

class DetailHabitViewController: UIViewController {
    // MARK: - UIComponenets

    let navigationBar = CustomNavigationBar("습관 상세", state: .navigation)
    
    lazy var editButton = UIButton().then {
        $0.setTitle("편집", for: .normal)
        $0.setTitleColor(.mainPurple, for: .normal)
    }
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    lazy var habitsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.collectionViewLayout = layout
        $0.register(cell: HabitButtonCollectionViewCell.self)
        $0.delegate = self
        $0.dataSource = self
    }
    
    let displayView = UIView().then {
        $0.backgroundColor = .gray1
        $0.cornerRound(radius: 10)
    }
    
    lazy var habitLabel = UILabel().then {
        $0.text = "런데이하기가"
        $0.font = .pretendard(type: .medium, size: 20)
        $0.textColor = .gray8
        $0.lineBreakMode = .byTruncatingTail
    }

    lazy var habitDayLabel = UILabel().then {
        $0.font = .pretendard(type: .bold, size: 52)
        $0.numberOfLines = 0
        $0.attributedText = NSMutableAttributedString()
            .addAttributeString(str: "5", size: 52, type: .bold, color: .mainPurple)
            .addAttributeString(str: self.habitAnnouncementText, size: 20, type: .bold, color: .gray8)
    }
    
    let messageLabel = UILabel().then {
        $0.textColor = .gray8
        $0.text = "오늘 행동해서 쌓인 걸 없애보아요!"
        $0.font = .pretendard(type: .medium, size: 12)
    }
    
    let calendar = FSCalendar()
    
    lazy var prevButton = UIButton().then {
        $0.setImage(UIImage(named: "iconPrev"), for: .normal)
        $0.addTarget(self, action: #selector(didTapPrevButton(_:)), for: .touchUpInside)
    }

    lazy var nextButton = UIButton().then {
        $0.setImage(UIImage(named: "iconNext"), for: .normal)
        $0.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
    }
    
    lazy var calenderHeaderLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.attributedText = NSMutableAttributedString()
            .addAttributeString(str: "5월\n", size: 20, color: .gray8)
            .addAttributeString(str: "2021", size: 14, type: .semiBold, color: .gray6)
    }
    
    lazy var giveUpButton = UIButton().then {
        let text = "습관 포기"
        $0.setTitle(text, for: .normal)
        $0.setTitleColor(.gray7, for: .normal)
        $0.titleLabel?.font = .pretendard(type: .medium, size: 16)
        let title = NSMutableAttributedString(string: text)
        title.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange(location: 0, length: text.count))
        $0.titleLabel?.attributedText = title
    }

    // MARK: - Properties
    
    private let buttonWidth = 103 * DeviceConstants.widthRatio
    private let habitAnnouncementText = "일차\n쌓이고 있어요"
    private var currPage = Date()
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setCalendar()
        setDelegate()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Actions
    
    @objc
    func didTapNextButton(_ sender: UIButton) {}

    @objc
    func didTapPrevButton(_ sender: UIButton) {}

    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .white
    }
    
    func setDelegate() {
        navigationBar.navigationDelegate = self
    }
    
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
            make.height.equalTo(203 * DeviceConstants.heightRatio)
            make.centerX.equalToSuperview()
        }
        
        habitLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        habitDayLabel.snp.makeConstraints { make in
            make.top.equalTo(habitLabel.snp.bottom)
            make.leading.equalTo(habitLabel.snp.leading)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.leading.equalTo(habitDayLabel.snp.leading)
            make.bottom.equalToSuperview().offset(-34)
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
    
    func setCalendar() {
        calendar.scope = .month
        calendar.dataSource = self

        /// 요일 한글 변환
        calendar.locale = Locale(identifier: "ko_KR")

        /// 날짜 선택
        calendar.allowsMultipleSelection = false
        calendar.allowsSelection = false

        /// textColor
        calendar.appearance.weekdayTextColor = .gray8

        /// hide top, bottom border
//        calendar.clipsToBounds = true

        calendar.today = nil /// 오늘 표시 숨기기

        /// Header
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.headerHeight = 0

//        calendarHeaderLabel.text = dateFormatter.string(from: calendar.currentPage)
    }
}

extension DetailHabitViewController: NavigationDelegate {
    func pop() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewFlowLayout

extension DetailHabitViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = habitsCollectionView.frame.height
        return CGSize(width: buttonWidth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        ((habitsCollectionView.frame.width - (buttonWidth * 3)) / 2)
    }
}

// MARK: - UICollectionViewDataSource

extension DetailHabitViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HabitButtonCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        return cell
    }
}

/// 날짜 아래 이미지 띄우기
extension DetailHabitViewController: FSCalendarDataSource {}
