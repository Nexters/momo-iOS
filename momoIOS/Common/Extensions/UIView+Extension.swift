//
//  UIView+Extension.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/01/31.
//

import Foundation
import UIKit

// MARK: - view extension
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    /// 키보드 움직임에 따라서 움직이도록 함.
    func moveWithKeyboard(willShow keyboardWillShow: Bool, notification: NSNotification, safeAreaBottomInset: CGFloat = 0) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let keyboardcurveValue = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }
        
        let keyboardHeight = keyboardSize.height
        let curveOption = UIView.AnimationOptions(rawValue: keyboardcurveValue << 16)
        
        if keyboardWillShow {
            UIView.animate(withDuration: keyboardDuration, delay: 0, options: [curveOption]) { [weak self] in
                self?.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + safeAreaBottomInset)
            }
        } else {
            UIView.animate(withDuration: keyboardDuration, delay: 0, options: [curveOption]) { [weak self] in
                self?.transform = .identity
            }
        }
    }
}
