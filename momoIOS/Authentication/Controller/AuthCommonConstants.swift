//
//  Constants.swift
//  momoIOS
//
//  Created by 문다 on 2023/01/30.
//

import UIKit

// MARK: - Colors

// MARK: - Buttons
func pushAnotherViewButton(subtitle: String, title: String) -> UIButton {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(
        string: subtitle,
        attributes: [NSAttributedString.Key.font: UIFont.body16,
                     NSAttributedString.Key.foregroundColor: UIColor.gray700])
    attributedTitle.append(NSAttributedString(
        string: "  \(title)",
        attributes: [NSAttributedString.Key.font: UIFont.body16,
                     NSAttributedString.Key.foregroundColor: UIColor.gray800]))
    button.setAttributedTitle(attributedTitle, for: .normal)
    return button
}

// MARK: - Methods
func setupAreaLabel(text: String) -> UILabel {
    let label = UILabel()
    label.text = "\(text)"
    label.textColor = UIColor.gray700
    label.font = .body16
    return label
}

func setupPushHelpButton(helpType: String) -> UIButton {
    let button = UIButton(type: .system)
    let attributedTitle = NSMutableAttributedString(
        string: "\(helpType)에 문제가 있나요?",
        attributes: [NSAttributedString.Key.font: UIFont.body16,
                     NSAttributedString.Key.foregroundColor: UIColor.gray600])
    button.setAttributedTitle(attributedTitle, for: .normal)
    return button
}

func setupUIStackView(_ views: [UIView]) -> UIStackView {
    let container = UIStackView(arrangedSubviews: views)
    container.axis = .vertical
    container.spacing = 10
    return container
}
