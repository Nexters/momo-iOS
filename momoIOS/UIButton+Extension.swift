//
//  UIButton+Extension.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/01.
//

import UIKit

extension UIButton {
    func setTitle(_ title: String, size: CGFloat, weight: UIFont.Weight, color: UIColor) {
        if #available(iOS 15.0, *) {
            var attributedTitle = AttributedString(title)
            attributedTitle.font = .systemFont(ofSize: size, weight: weight)
            attributedTitle.foregroundColor = color
            var configuration = self.configuration ?? .plain()
            configuration.attributedTitle = attributedTitle
            self.configuration = configuration
        } else {
            self.setTitle(title, for: .normal)
            self.titleLabel?.font = .systemFont(ofSize: size, weight: weight)
            self.setTitleColor(color, for: .normal)
        }
    }
    
    func configurate(
        bgColor: UIColor = .clear,
        strokeColor: UIColor? = nil,
        strokeWidth: CGFloat = 0,
        cornerRadius: CGFloat = 0,
        margin: CGFloat? = nil
    ) {
        if #available(iOS 15.0, *) {
            var configuration = self.configuration ?? .plain()
            configuration.background.backgroundColor = bgColor
            configuration.background.strokeColor = strokeColor
            configuration.background.strokeWidth = strokeWidth
            configuration.background.cornerRadius = cornerRadius
            margin.map {
                configuration.contentInsets = .init(top: $0, leading: $0, bottom: $0, trailing: $0)
            }
            self.configuration = configuration
        } else {
            self.backgroundColor = bgColor
            self.layer.cornerRadius = cornerRadius
            self.layer.borderWidth = strokeWidth
            self.layer.borderColor = strokeColor?.cgColor
            margin.map {
                self.contentEdgeInsets = .init(top: $0, left: $0, bottom: $0, right: $0)
            }
        }
    }
}
