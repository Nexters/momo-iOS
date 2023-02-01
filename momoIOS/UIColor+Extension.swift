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
    
    convenience init(red: Int, green: Int, blue:Int, a:CGFloat){
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0, alpha: a)
    }
    
    convenience init(Hex: Int, alpha: CGFloat = 1.0){
        self.init(red: (Hex >> 16) & 0xFF, green: (Hex >> 8) & 0xFF,
                  blue: Hex & 0xFF, a: alpha)
    }
}
