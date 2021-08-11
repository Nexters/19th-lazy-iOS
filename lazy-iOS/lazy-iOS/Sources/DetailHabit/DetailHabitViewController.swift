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
        $0.cornerRound(radius: 12)
    }
    
    lazy var habitLabel = UILabel().then {
        $0.text = "런데이하기"
        $0.font = .pretendard(type: .medium, size: 18)
        $0.textColor = .gray8
        $0.lineBreakMode = .byTruncatingTail
        $0.lineSpacing(spacing: 8)
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
    
    lazy var calendarHeaderLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    lazy var giveUpButton = UIButton().then {
        let text = "습관 포기"
        $0.setTitle(text, for: .normal)
        $0.setTitleColor(.gray7, for: .normal)
        $0.titleLabel?.font = .pretendard(type: .medium, size: 16)
        let title = NSMutableAttributedString(string: text)
        title.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange(location: 0, length: text.count))
        $0.titleLabel?.attributedText = title
        $0.addTarget(self, action: #selector(didTapGiveUpButton(_:)), for: .touchUpInside)
    }

    // MARK: - Properties
    
    let buttonWidth = 103 * DeviceConstants.widthRatio
    let habitAnnouncementText = " 일차\n쌓이고 있어요"
    private var currPage = Date() {
        didSet {
            changeCalendarHeaderLabel(to: currPage)
        }
    }
    
    // MARK: - Initializer
    
    init() {
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
    func didTapNextButton(_ sender: UIButton) {
        didChangeCalendarPage(at: 1)
    }

    @objc
    func didTapPrevButton(_ sender: UIButton) {
        didChangeCalendarPage(at: -1)
    }
    
    @objc
    func didTapGiveUpButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "이대로 습관을\n포기하시겠다구요?", message: "포기하면 다시 되돌릴 수 없어요", preferredStyle: .alert)
        
        let continueAction = UIAlertAction(title: "계속하기", style: .cancel, handler: nil)
        let giveUpAction = UIAlertAction(title: "포기하기", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(giveUpAction)
        alert.addAction(continueAction)
        
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Methods
    
    func setView() {
        view.backgroundColor = .white
    }
    
    func setDelegate() {
        navigationBar.navigationDelegate = self
        calendar.dataSource = self
        calendar.delegate = self
    }
    
    func setCalendar() {
        calendar.scope = .month

        /// 요일 한글 변환
        calendar.locale = Locale(identifier: "ko_KR")

        /// 날짜 선택
        calendar.allowsMultipleSelection = false
        calendar.allowsSelection = false

        /// textColor
        calendar.appearance.weekdayTextColor = .gray8
        calendar.appearance.weekdayFont = .pretendard(type: .semiBold, size: 14)
        calendar.appearance.titleDefaultColor = .gray8
        calendar.appearance.titleFont = .pretendard(type: .regular, size: 14)

        calendar.today = nil /// 오늘 표시 숨기기

        /// Header
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.headerHeight = 0
        
        currPage = Date()
    }
    
    func didChangeCalendarPage(at page: Int) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = page

        currPage = cal.date(byAdding: dateComponents, to: currPage) ?? Date()
        calendar.setCurrentPage(currPage, animated: true)
    }
    
    func changeCalendarHeaderLabel(to date: Date) {
        let month = Date().dateToString(format: "M월\n", date: date)
        let year = Date().dateToString(format: "YYYY", date: date)
        
        calendarHeaderLabel.attributedText = NSMutableAttributedString()
            .addAttributeString(str: month, size: 20, color: .gray8)
            .addAttributeString(str: year, size: 14, type: .semiBold, color: .gray6)
    }
}

extension DetailHabitViewController: FSCalendarDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        currPage = calendar.currentPage
    }
}
