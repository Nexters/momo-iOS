//
//  InputMoimYearViewController.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/13.
//

import UIKit
import SnapKit

class InputMoimYearController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    private var isEditingCode: Bool {
        return self.codeField.isEditing
    }
    
    private lazy var titleLabel = CommonTitleLabel(labelText: "활동기수를\n입력해주세요")
    private lazy var codeField = CommonTextField(placeholderText: "")
    private lazy var nextButton = CommonActionButton(buttonTitle: "다음")
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupKeyboardNotifications()
        self.setupAction()
        self.codeField.keyboardType = .numberPad
        self.view.backgroundColor = .white
        self.setupCustomNav()
        self.setupLayout()
        self.codeField.becomeFirstResponder()
        
        nextButton.backgroundColor = .gray600
        nextButton.setTitleColor(UIColor(hex: 0xFFFFFF, alpha: 0.4), for: .normal)
        nextButton.isEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Selectors
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if self.isEditingCode {
            self.nextButton.moveWithKeyboard(
                willShow: true,
                notification: notification,
                safeAreaBottomInset: self.view.safeAreaInsets.bottom
            )
        }
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        self.nextButton.moveWithKeyboard(
            willShow: false,
            notification: notification,
            safeAreaBottomInset: self.view.safeAreaInsets.bottom
        )
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        codeField.backgroundColor = UIColor.textbox2
        codeField.layer.borderWidth = 1
        codeField.layer.borderColor = UIColor.stroke.cgColor
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        codeField.backgroundColor = .textbox1
        codeField.layer.borderWidth = 0
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.count == 0 {
            nextButton.backgroundColor = .gray600
            nextButton.setTitleColor(UIColor(hex: 0xFFFFFF, alpha: 0.4), for: .normal)
            nextButton.isEnabled = false
        } else {
            nextButton.backgroundColor = .main
            nextButton.setTitleColor(.white, for: .normal)
            nextButton.isEnabled = true
        }
    }
    
    @objc func goToNextVC() {
            self.navigationController?.pushViewController(InputSecurityCodeViewController(), animated: true)
    }
    
    // MARK: - Helpers
    
    private func setupAction() {
        self.nextButton.addTarget(self, action: #selector(goToNextVC), for: .touchUpInside)
        self.codeField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        self.codeField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        self.codeField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func setupCustomNav() {
        let navBar = self.navigationController?.navigationBar
        navBar?.tintColor = .gray800
        navBar?.backIndicatorImage = UIImage(systemName: "arrow.left")
        navBar?.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
        navBar?.topItem?.title = ""
        
        let titleView = UILabel()
        titleView.text = "활동시작"
        titleView.textColor = .gray800
        titleView.font = .body16
        navigationItem.titleView = titleView
    }
    
    private func setupLayout() {
        view.addSubviews(titleLabel, codeField, nextButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(27)
            make.leading.equalToSuperview().offset(24)
        }
        
        codeField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(58)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
    }
}
