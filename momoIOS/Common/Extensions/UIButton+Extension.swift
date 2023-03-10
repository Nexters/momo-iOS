//
//  UIButton+Extension.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/01.
//

import UIKit

extension UIButton {
    func setTitle(_ title: String, font: UIFont, color: UIColor) {
        if #available(iOS 15.0, *) {
            var attributedTitle = AttributedString(title)
            attributedTitle.font = font
            attributedTitle.foregroundColor = color
            var configuration = self.configuration ?? .plain()
            configuration.attributedTitle = attributedTitle
            self.configuration = configuration
        } else {
            self.setTitle(title, for: .normal)
            self.titleLabel?.font = font
            self.setTitleColor(color, for: .normal)
        }
    }
    
    func setTitle(_ title: String, size: CGFloat, weight: UIFont.Weight, color: UIColor) {
        let font = UIFont.pretendard(size: size, weight: weight)
        self.setTitle(title, font: font, color: color)
    }
    
    func configurate(
        bgColor: UIColor? = nil,
        strokeColor: UIColor? = nil,
        strokeWidth: CGFloat? = nil,
        cornerRadius: CGFloat? = nil,
        edgeInsets: NSDirectionalEdgeInsets? = nil
    ) {
        if #available(iOS 15.0, *) {
            var configuration = self.configuration ?? .plain()
            bgColor.map { configuration.background.backgroundColor = $0 }
            strokeColor.map { configuration.background.strokeColor = $0 }
            strokeWidth.map { configuration.background.strokeWidth = $0 }
            cornerRadius.map { configuration.background.cornerRadius = $0 }
            edgeInsets.map { configuration.contentInsets = $0 }
            self.configuration = configuration
        } else {
            bgColor.map { self.backgroundColor = $0 }
            strokeColor.map { self.layer.borderColor = $0.cgColor }
            strokeWidth.map { self.layer.borderWidth = $0 }
            cornerRadius.map { self.layer.cornerRadius = $0 }
            edgeInsets.map { self.contentEdgeInsets = .init(top: $0.top, left: $0.leading, bottom: $0.bottom, right: $0.trailing) }
        }
    }
    
    func configurate(
        bgColor: UIColor? = nil,
        strokeColor: UIColor? = nil,
        strokeWidth: CGFloat? = nil,
        cornerRadius: CGFloat? = nil,
        padding: CGFloat? = nil
    ) {
        let edgeInsets = padding.map { NSDirectionalEdgeInsets(top: $0, leading: $0, bottom: $0, trailing: $0) }
        self.configurate(bgColor: bgColor, strokeColor: strokeColor, strokeWidth: strokeWidth, cornerRadius: cornerRadius, edgeInsets: edgeInsets)
    }
    
    func setImage(_ image: UIImage?, tintColor: UIColor, padding: CGFloat, direction: NSDirectionalRectEdge) {
        if #available(iOS 15.0, *) {
            var configuration = self.configuration ?? .plain()
            configuration.imagePadding = padding / 2
            configuration.image = image
            configuration.titlePadding = padding / 2
            configuration.imagePlacement = direction
            self.configuration = configuration
            self.tintColor = tintColor
        } else {
            self.setImage(image, for: .normal)
            self.tintColor = tintColor
            if direction == .trailing {
                self.semanticContentAttribute = .forceRightToLeft
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: padding / 2, bottom: 0, right: 0)
                self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: padding / 2)
            } else if direction == .leading {
                self.semanticContentAttribute = .forceLeftToRight
                self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: padding / 2)
                self.contentEdgeInsets = UIEdgeInsets(top: 0, left: padding / 2, bottom: 0, right: 0)
            }
        }
    }
}
