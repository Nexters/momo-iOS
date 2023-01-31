//
//  UIColor+Extension.swift
//  momoIOS
//
//  Created by 임수현 on 2023/01/31.
//

import UIKit

extension UIColor {
    /// Figma rgba를 그대로 활용할 수 있는 확장 메소드.
    /// rgb는 0~255 기준으로, alpha는 0~1 기준으로 사용
    static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}