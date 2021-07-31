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
    }
    
    private let mainLabel = UILabel().then {
        $0.font = .pretendard(type: .bold, size: 24)
        $0.text = "오늘 해야 할 습관이\n젤리로 쌓여요"
        $0.numberOfLines = 0
        $0.textColor = .white
        $0.lineSpacing(spacing: 10)
    }

    private let subLabel = UILabel().then {
        $0.font = .pretendard(type: .medium, size: 16)
        $0.text = "어제 밀린 일을 없애고\n오늘 당장의 할 일에 집중해요"
        $0.numberOfLines = 0
        $0.textColor = .white
        $0.lineSpacing(spacing: 10)
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

    // MARK: - Properties
    
    private var currPage: Int = 0
    
    // MARK: - Initializer
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setGesture()
        setConstraints()
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
        view.addSubviews([backgroundImageView, skipButton, mainLabel, subLabel, imageView, pageControl])
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(65)
            make.trailing.equalToSuperview().offset(-35)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(126)
            make.leading.equalToSuperview().offset(33)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(26)
            make.leading.equalTo(mainLabel.snp.leading)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(108)
            make.width.equalToSuperview().multipliedBy(299.0 / 375.0)
            make.height.equalTo(imageView.snp.width).multipliedBy(234.0 / 299.0)
            make.centerX.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-78)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Protocols
}
