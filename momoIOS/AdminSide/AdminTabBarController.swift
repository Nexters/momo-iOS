//
//  AdminTabBarController.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/26.
//

import UIKit

final class AdminTabBarController: UITabBarController {
    private enum Constant {
        static var sessionImage: UIImage? { UIImage(named: "tab_work") }
        static var memberImage: UIImage? { UIImage(named: "tab_member") }
        static var settingImage: UIImage? { UIImage(named: "tab_setting") }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sessionTab = UINavigationController(rootViewController: AdminSessionTableViewController())
        sessionTab.tabBarItem = .init(title: "세션관리", image: Constant.sessionImage, tag: 0)
        let memberTab = UINavigationController(rootViewController: MemberManagementViewController())
        memberTab.tabBarItem = .init(title: "회원관리", image: Constant.memberImage, tag: 1)
        let settingTab = UINavigationController(rootViewController: MoimManagementController())
        settingTab.tabBarItem = .init(title: "모임관리", image: Constant.settingImage, tag: 2)
        
        self.setViewControllers([sessionTab, memberTab, settingTab], animated: true)
        self.tabBar.tintColor = .main
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
