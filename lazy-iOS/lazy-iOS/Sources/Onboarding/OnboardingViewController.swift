//
//  OnboardingViewController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/08/01.
//

import UIKit

class OnboardingViewController: UIViewController {
    // MARK: - UIComponenets
    
    let backgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "bg")
    }
    
    private let skipButton = UIButton().then {
        let text = "건너뛰기"
        let title = NSMutableAttributedString(string: text)
        title.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange(location: 0, length: text.count))
        $0.titleLabel?.font = .pretendard(type: .medium, size: 14)
        $0.titleLabel?.attributedText = title
        $0.setTitle(text, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
    }
    
    private lazy var mainLabel = UILabel().then {
        $0.font = .pretendard(type: .bold, size: 24)
        $0.text = self.mainLabelTextArr.first
        $0.numberOfLines = 0
        $0.textColor = .white
        $0.lineSpacing(spacing: 5)
    }

    private lazy var subLabel = UILabel().then {
        $0.font = .pretendard(type: .medium, size: 16)
        $0.text = self.subLabelTextArr.first
        $0.numberOfLines = 0
        $0.textColor = .white
        $0.lineSpacing(spacing: 5)
    }
    
    private let imageView = UIImageView().then {
        $0.image = UIImage(named: "onboarding1")
    }
    
    private let pageControl = UIPageControl().then {
        $0.numberOfPages = 3
        $0.pageIndicatorTintColor = .white.withAlphaComponent(0.5)
        $0.currentPageIndicatorTintColor = .white
        $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
    }
    
    private lazy var nextButton = RoundedButton(style: .white).then {
        $0.setTitle("더 이상 게으르지 않겠어요", for: .normal)
        $0.isHidden = true
        $0.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
    }

    // MARK: - Properties
    
    private var currPage: Int = 0 {
        didSet {
            if currPage == pageControl.numberOfPages - 1 {
                nextButton.isHidden = false
                pageControl.isHidden = true
            } else {
                nextButton.isHidden = true
                pageControl.isHidden = false
            }
        }
    }

    private var mainLabelTextArr = ["오늘 해야 할 습관이\n젤리로 쌓여요", "젤리가 얼마나 쌓였는지\n확인하고 없애보세요!", "얼마나 많이 미뤘든\n당장 행동하세요"]
    private var subLabelTextArr = ["어제 밀린 일을 없애고\n오늘 당장의 할 일에 집중해요", "이만큼 쌓였는데\n안 없애고는 못 배기겠죠?", "밍굴맹굴과 함께라면\n나태했던 어제와는 달리\n한 걸음 더 나아갈 수 있어요"]
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGesture()
        setConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    // MARK: - Actions
    
    @objc
    func handleSwipeGesture(_ gesture: UIGestureRecognizer) {
        guard let swipeGesture = gesture as? UISwipeGestureRecognizer else { return }
        
        switch swipeGesture.direction {
        case UISwipeGestureRecognizer.Direction.left:
            currPage += 1
        case UISwipeGestureRecognizer.Direction.right:
            currPage -= 1
        default:
            break
        }

        guard (0 ..< pageControl.numberOfPages).contains(currPage) else {
            currPage = currPage < 0 ? 0 : pageControl.numberOfPages - 1
            return
        }
        
        pageControl.currentPage = currPage
        imageView.image = UIImage(named: "onboarding\(currPage + 1)")
        mainLabel.text = mainLabelTextArr[currPage]
        subLabel.text = subLabelTextArr[currPage]
        
        makeLabelTransition()
    }
    
    @objc
    func didTapNextButton(_ sender: UIButton) {
        navigationController?.pushViewController(TabBarController(), animated: true)
    }
    
    // MARK: - Methods
    
    func setGesture() {
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        rightGesture.direction = .right
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        leftGesture.direction = .left
        
        view.addGestureRecognizer(rightGesture)
        view.addGestureRecognizer(leftGesture)
    }
    
    func setConstraints() {
        view.addSubviews([backgroundImageView, skipButton, mainLabel, subLabel, imageView, pageControl, nextButton])
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65 * DeviceConstants.heightRatio)
            make.trailing.equalToSuperview().offset(-35)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(126 * DeviceConstants.heightRatio)
            make.leading.equalToSuperview().offset(33)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(26 * DeviceConstants.heightRatio)
            make.leading.equalTo(mainLabel.snp.leading)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(108 * DeviceConstants.heightRatio)
            make.width.equalToSuperview().multipliedBy(299.0 / 375.0)
            make.height.equalTo(imageView.snp.width).multipliedBy(234.0 / 299.0)
            make.centerX.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-78 * DeviceConstants.heightRatio)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(320.0 / 375.0)
            make.height.equalTo(nextButton.snp.width).multipliedBy(60.0 / 320.0)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30 * DeviceConstants.heightRatio)
        }
    }
    
    func makeLabelTransition() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = .init(name: .easeInEaseOut)
        transition.type = .fade
        
        mainLabel.layer.add(transition, forKey: CATransitionType.push.rawValue)
        subLabel.layer.add(transition, forKey: CATransitionType.push.rawValue)
    }
    
    // MARK: - Protocols
}
