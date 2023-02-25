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
            attributedTitle.font = .pretendard(size: size, weight: weight)
            attributedTitle.foregroundColor = color
            var configuration = self.configuration ?? .plain()
            configuration.attributedTitle = attributedTitle
            self.configuration = configuration
        } else {
            self.setTitle(title, for: .normal)
            self.titleLabel?.font = .pretendard(size: size, weight: weight)
            self.setTitleColor(color, for: .normal)
        }
    }
    
    func configurate(
        bgColor: UIColor = .clear,
        strokeColor: UIColor? = nil,
        strokeWidth: CGFloat = 0,
        cornerRadius: CGFloat = 0,
        edgeInsets: NSDirectionalEdgeInsets? = nil
    ) {
        if #available(iOS 15.0, *) {
            var configuration = self.configuration ?? .plain()
            configuration.background.backgroundColor = bgColor
            configuration.background.strokeColor = strokeColor
            configuration.background.strokeWidth = strokeWidth
            configuration.background.cornerRadius = cornerRadius
            edgeInsets.map {
                configuration.contentInsets = $0
            }
            self.configuration = configuration
        } else {
            self.backgroundColor = bgColor
            self.layer.cornerRadius = cornerRadius
            self.layer.borderWidth = strokeWidth
            self.layer.borderColor = strokeColor?.cgColor
            edgeInsets.map {
                self.contentEdgeInsets = .init(top: $0.top, left: $0.leading, bottom: $0.bottom, right: $0.trailing)
            }
        }
    }
    
    func configurate(
        bgColor: UIColor = .clear,
        strokeColor: UIColor? = nil,
        strokeWidth: CGFloat = 0,
        cornerRadius: CGFloat = 0,
        padding: CGFloat? = nil
    ) {
        let edgeInsets = padding.map { NSDirectionalEdgeInsets(top: $0, leading: $0, bottom: $0, trailing: $0) }
        self.configurate(bgColor: bgColor, strokeColor: strokeColor, strokeWidth: strokeWidth, cornerRadius: cornerRadius, edgeInsets: edgeInsets)
    }
}
