//
//  Constants.swift
//  momoIOS
//
//  Created by 문다 on 2023/01/30.
//

import UIKit

// MARK: - Colors
let defaultButtonColor: UIColor = .rgba(56, 56, 56, 1)

// MARK: - Buttons
func pushAnotherViewButton(subtitle: String, title: String) -> UIButton {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(
        string: subtitle,
        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                     NSAttributedString.Key.foregroundColor: UIColor.gray])
    attributedTitle.append(NSAttributedString(
        string: "  \(title)",
        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                     NSAttributedString.Key.foregroundColor: UIColor.black]))
    button.setAttributedTitle(attributedTitle, for: .normal)
    return button
}

let pushHelpLogin: UIButton = {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(
        string: "로그인에 문제가 있나요?",
        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                     NSAttributedString.Key.foregroundColor: UIColor.gray])
    button.setAttributedTitle(attributedTitle, for: .normal)
    return button
}()

// MARK: - Methods
func setupUIStackView(_ views: [UIView]) -> UIStackView {
    let container = UIStackView(arrangedSubviews: views)
    container.axis = .vertical
    container.spacing = 5
    return container
}
