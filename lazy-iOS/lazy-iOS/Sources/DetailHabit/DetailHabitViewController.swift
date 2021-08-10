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
    
    let buttonWidth = 103 * DeviceConstants.widthRatio
    let habitAnnouncementText = "일차\n쌓이고 있어요"
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
