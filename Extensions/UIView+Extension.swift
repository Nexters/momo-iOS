//
//  UIView+Extension.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/01/31.
//

import Foundation

// MARK: - view extension
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
