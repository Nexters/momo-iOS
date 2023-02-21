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
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(red: (hex >> 16) & 0xFF, green: (hex >> 8) & 0xFF,
                  blue: hex & 0xFF, alpha: alpha)
    }
    
    static let main = UIColor(hex: 0x946BEA)
    static let gray800 = UIColor(hex: 0x222222)
    static let gray700 = UIColor(hex: 0x4F505C)
}
