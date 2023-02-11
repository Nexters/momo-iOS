//
//  UINavigationController+Extension.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/11.
//

import UIKit

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        // backButton을 임의로 변경하면 swipe back 동작이 되지 않기 떄문에 gestureRecognizer를 설정하여 동작하도록 함.
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
