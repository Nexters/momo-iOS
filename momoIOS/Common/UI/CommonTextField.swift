//
//  CommonTextField.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/11.
//

import UIKit
import SnapKit

class CommonTextField: UITextField {
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupTextField()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupTextField()
    }
    
    convenience init(placeholderText: String, isSecure: Bool = false) {
        self.init(frame: .zero)
        self.placeholder = placeholderText
        self.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray500,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)
                        ])
        self.isSecureTextEntry = isSecure
    }

    // MARK: - Helpers
    
    private func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
    
    private func setupTextField() {
        self.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        self.backgroundColor = .rgba(248, 248, 249, 1)
        self.layer.cornerRadius = 8
        self.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.textColor = .gray700
        self.addLeftPadding()
    }
}
