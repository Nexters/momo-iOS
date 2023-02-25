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
    
    // Key Color
    /// 0x946BEA
    static let main = UIColor(hex: 0x946BEA)
    /// 0xF4EFFF
    static let p100 = UIColor(hex: 0xF4EFFF)
    /// 0xDEF1FF
    static let b100 = UIColor(hex: 0xDEF1FF)
    /// 0x7479E7
    static let b400 = UIColor(hex: 0x7479E7)
    /// 0xD5CCEE
    static let stroke = UIColor(hex: 0xD5CCEE)
    /// 0xFF6464
    static let warning = UIColor(hex: 0xFF6464)
    /// 0x7FCBE5
    static let attendanceCheck = UIColor(hex: 0x7FCBE5)
    /// 0xFFC531
    static let attendanceLate = UIColor(hex: 0xFFC531)
    /// 0xFF8B32
    static let noticeAbsance = UIColor(hex: 0xFF8B32)
    
    // Text Color
    /// 0x222222
    static let gray800 = UIColor(hex: 0x222222)
    /// 0x4F505C
    static let gray700 = UIColor(hex: 0x4F505C)
    /// 0x727484
    static let gray600 = UIColor(hex: 0x727484)
    /// 0xB3B6C5
    static let gray500 = UIColor(hex: 0xB3B6C5)
    
    // Background
    /// 0xF6F6F6
    static let background = UIColor(hex: 0xF6F6F6)
    /// 0xF8F8F9
    static let textbox1 = UIColor(hex: 0xF8F8F9)
    /// 0xF8F8FE
    static let textbox2 = UIColor(hex: 0xF8F8FE)
    /// 0xE7E8EC
    static let pastbox = UIColor(hex: 0xE7E8EC)
}
