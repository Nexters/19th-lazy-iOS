//
//  TabBarController.swift
//  lazy-iOS
//
//  Created by inae Lee on 2021/07/19.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setTabBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setTabBar() {
        tabBar.isTranslucent = false
        tabBar.tintColor = .mainPurple
        tabBar.unselectedItemTintColor = .gray5
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .white
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.pretendard(type: .medium, size: 12), NSAttributedString.Key.foregroundColor: UIColor.gray5], for: .normal)

        let main = HomeViewController()
        let mainBarItem = UITabBarItem(title: "홈", image: UIImage(named: "iconHome"), tag: 0)
        main.tabBarItem = mainBarItem

        let analysis = AnalysisViewController()
        let analysisBarItem = UITabBarItem(title: "분석", image: UIImage(named: "iconAnalysis"), tag: 1)
        analysis.tabBarItem = analysisBarItem

        let myPage = MyPageViewController()
        let myPageBarItem = UITabBarItem(title: "마이", image: UIImage(named: "iconMyPage"), tag: 2)
        myPage.tabBarItem = myPageBarItem

        viewControllers = [main, analysis, myPage]
    }
}
