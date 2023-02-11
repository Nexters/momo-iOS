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
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.isSecureTextEntry = isSecure
    }

    // MARK: - Helpers
    private func setupTextField() {
        self.snp.makeConstraints { make in
            make.height.equalTo(55)
        }
        self.borderStyle = .roundedRect
        self.font = UIFont.systemFont(ofSize: 16)
        self.textColor = .black
    }
}
