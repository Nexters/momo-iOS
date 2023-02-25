//
//  CommonTitleLabel.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/11.
//

import UIKit

class CommonTitleLabel: UILabel {
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLabel()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupLabel()
    }
    
    convenience init(labelText: String) {
        self.init(frame: .zero)
        self.text = "\(labelText)"
    }
    
    // MARK: - Helpers
    
    private func setupLabel() {
        self.numberOfLines = 0
        self.font = .pretendard(size: 28, weight: .w600)
        self.textColor = .gray800
    }
}
