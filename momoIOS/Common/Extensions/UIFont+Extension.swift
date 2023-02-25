//
//  UIFont+Extension.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/23.
//

import UIKit

extension UIFont {
    static func pretendard(size fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "Pretendard"

        var weightString: String
        switch weight {
        case .black:
            weightString = "Black"
        case .bold:
            weightString = "Bold"
        case .heavy:
            weightString = "ExtraBold"
        case .ultraLight:
            weightString = "ExtraLight"
        case .light:
            weightString = "Light"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        case .semibold:
            weightString = "SemiBold"
        case .thin:
            weightString = "Thin"
        default:
            weightString = "Regular"
        }

        return UIFont(name: "\(familyName)-\(weightString)", size: fontSize) ?? .systemFont(ofSize: fontSize, weight: weight)
    }

    // 자주 사용되는 FontSet
    /// semibold (600), 20
    static let title20: UIFont = .pretendard(size: 20, weight: .w600)
    
    /// medium (500), 12
    static let body12: UIFont = .pretendard(size: 12, weight: .w500)
    /// medium (500), 14
    static let body14: UIFont = .pretendard(size: 14, weight: .w500)
    /// medium (500), 16
    static let body16: UIFont = .pretendard(size: 16, weight: .w500)
    /// medium (500), 18
    static let body18: UIFont = .pretendard(size: 18, weight: .w500)
    
    /// regular (400), 12
    static let tag1: UIFont = .pretendard(size: 12, weight: .w400)
    /// bold (700), 12
    static let tag2: UIFont = .pretendard(size: 12, weight: .w700)
}

extension UIFont.Weight {
    /// regular
    static var w400: UIFont.Weight { .regular }
    /// medium
    static var w500: UIFont.Weight { .medium }
    /// semibold
    static var w600: UIFont.Weight { .semibold }
    /// bold
    static var w700: UIFont.Weight { .bold }
}
