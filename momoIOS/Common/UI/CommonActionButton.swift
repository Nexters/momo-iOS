//
//  CommonActionButton.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/11.
//

import UIKit

class CommonActionButton: UIButton {
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupButton()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupButton()
    }
    
    convenience init(buttonTitle: String) {
        self.init(frame: .zero)
        self.setTitle(buttonTitle, for: .normal)
    }

    // MARK: - Helpers
    private func setupButton() {
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = defaultButtonColor
        self.heightAnchor.constraint(equalToConstant: 55).isActive = true
        self.layer.cornerRadius = 8
        self.titleLabel?.font = .boldSystemFont(ofSize: 18)
    }
}
