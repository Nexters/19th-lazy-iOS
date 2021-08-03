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
        tabBar.tintColor = .black
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .white
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.pretendard(type: .bold, size: 12)], for: .normal)
        
        let main = HomeViewController()
        let mainBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        main.tabBarItem = mainBarItem
        
        let analysis = AnalysisViewController()
        let analysisBarItem = UITabBarItem(title: "분석", image: UIImage(systemName: "chart.bar"), selectedImage: UIImage(systemName: "chart.bar.fill"))
        analysis.tabBarItem = analysisBarItem
        
        let myPage = MyPageViewController()
        let myPageBarItem = UITabBarItem(title: "마이", image: UIImage(systemName: "tray.full"), selectedImage: UIImage(systemName: "tray.full.fill"))
        myPage.tabBarItem = myPageBarItem

        viewControllers = [main, analysis, myPage]
    }
}
