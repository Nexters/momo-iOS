//
//  UIApplication+Extension.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/25.
//

import UIKit

extension UIApplication {
    static func topViewController() -> UIViewController? {
        UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController
    }
}
