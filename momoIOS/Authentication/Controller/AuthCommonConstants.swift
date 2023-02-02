//
//  Constants.swift
//  momoIOS
//
//  Created by 문다 on 2023/01/30.
//

import UIKit

// MARK: - Colors
let authDefaultButtonColor: UIColor = .rgba(56, 56, 56, 1)

// MARK: - UILabel
let welcomeTitle: UILabel = {
    let title = UILabel()
    title.text = "간단한 출석체크,\n모두모여에서"
    title.font = UIFont.systemFont(ofSize: 40, weight: .regular)
    title.numberOfLines = 0
    return title
}()

// MARK: - UITextField
func inputContainerView(placeholder: String, isSecureField: Bool = false) -> UITextField {
    let textfield = UITextField()
    textfield.heightAnchor.constraint(equalToConstant: 55).isActive = true
    textfield.placeholder = placeholder
    textfield.borderStyle = .roundedRect
    textfield.font = UIFont.systemFont(ofSize: 16)
    textfield.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
    textfield.isSecureTextEntry = isSecureField
    return textfield
}

// MARK: - Buttons
func actionButton(title: String) -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle(title, for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.backgroundColor = authDefaultButtonColor
    button.heightAnchor.constraint(equalToConstant: 55).isActive = true
    button.layer.cornerRadius = 8
    button.titleLabel?.font = .boldSystemFont(ofSize: 18)
    return button
}

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
