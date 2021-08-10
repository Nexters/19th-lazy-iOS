//
//  DetailHabitViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/05.
//

import UIKit

class DetailHabitViewController: UIViewController {
    // MARK: - UIComponenets

    let navigationBar = CustomNavigationBar("습관 상세", state: .navigation)
    
    lazy var editButton = UIButton().then {
        $0.setTitle("편집", for: .normal)
        $0.setTitleColor(.mainPurple, for: .normal)
    }
    
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

    // MARK: - Properties
    
    private let buttonWidth = 103 * DeviceConstants.widthRatio
    private let habitAnnouncementText = "일차\n쌓이고 있어요"
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        setDelegate()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Actions
    
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
        view.addSubviews([navigationBar, habitsCollectionView, displayView])
        
        editButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20 * DeviceConstants.widthRatio)
            make.centerY.equalToSuperview()
        }
        
        navigationBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        habitsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(38 * DeviceConstants.heightRatio)
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
