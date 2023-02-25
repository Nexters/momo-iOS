//
//  PaddingLabel.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/23.
//

import UIKit

class PaddingLabel: UILabel {
    var horizontalInset: CGFloat = 10.0
    var verticalInset: CGFloat = 4.0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("not implement required init?(coder: NSCoder)")
    }

    convenience init(radius: CGFloat, color: UIColor, verticalInset: CGFloat = 4.0, horizontalInset: CGFloat = 10.0) {
        self.init(frame: .zero)
        
        self.horizontalInset = horizontalInset
        self.verticalInset = verticalInset
        self.backgroundColor = color
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        super.drawText(in: rect.inset(by: insets))
    }
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + horizontalInset + horizontalInset, height: size.height + verticalInset + verticalInset)
    }
    override var bounds: CGRect {
        didSet { preferredMaxLayoutWidth = bounds.width - (horizontalInset + horizontalInset) }
    }
}
