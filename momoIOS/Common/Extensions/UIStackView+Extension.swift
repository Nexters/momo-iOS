//
//  UIStackView+Extension.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/03.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
