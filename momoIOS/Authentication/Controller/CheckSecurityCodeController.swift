//
//  CheckSecurityCodeController.swift
//  momoIOS
//
//  Created by 문다 on 2023/01/30.
//

import UIKit

class CheckSecurityCodeController: UIViewController {
    
    // MARK: - Properties
    private lazy var titlePhrase = CommonTitleLabel(labelText: "보안코드를\n입력해주세요.")
    private lazy var guidePhrase: UILabel = {
        let label = UILabel()
        label.text = "보안코드를 모를 경우 운영진에게 문의해주세요"
        label.font = .body16
        label.textColor = .gray600
        return label
    }()
    private let codeField = CommonTextField(placeholderText: "보안코드")
    private let nextButton = CommonActionButton(buttonTitle: "다음")
    
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupKeyboardNotifications()
        codeField.delegate = self
        codeField.becomeFirstResponder()
        view.backgroundColor = .white
        
        setupNavCustom()
        setupLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        codeField.layer.borderWidth = 1
        codeField.layer.borderColor = UIColor(hex: 0xD5CCEE).cgColor
        codeField.backgroundColor = UIColor.textbox2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        codeField.layer.borderWidth = 0
        codeField.backgroundColor = UIColor.textbox1
    }
    
    // MARK: Selectors
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text?.count == 0 {
            nextButton.backgroundColor = .gray600
            nextButton.setTitleColor(UIColor(hex: 0xFFFFFF, alpha: 0.4), for: .normal)
            nextButton.isEnabled = false
        } else {
            nextButton.backgroundColor = .main
            nextButton.setTitleColor(.white, for: .normal)
            nextButton.isEnabled = true
        }
    }
    
    @objc func handleCompleteRegistration() {
        let controller = InputMemberInfoController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func setupKeyboardNotifications() {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(self.keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil)

            NotificationCenter.default.addObserver(
                self,
                selector: #selector(self.keyboardWillHide),
                name: UIResponder.keyboardWillHideNotification,
                object: nil)
    }
    
    // MARK: - Actions
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
    
    // MARK: - Helpers
    
    private func setupNavCustom() {
        let navBar = self.navigationController?.navigationBar
        navBar?.isHidden = false
        navBar?.tintColor = .gray800
        navBar?.backIndicatorImage = UIImage(systemName: "arrow.left")
        navBar?.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
        navBar?.topItem?.title = ""
        
        let title = UILabel()
        title.text = "회원가입"
        title.textColor = .gray800
        title.font = .body16
        self.navigationItem.titleView = title
    }
    
    private func setupLayout() {
        view.addSubviews(titlePhrase, guidePhrase, codeField, nextButton)

        titlePhrase.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.equalToSuperview().offset(20)
        }
        
        guidePhrase.snp.makeConstraints { make in
            make.top.equalTo(titlePhrase.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(24)
        }
        
        codeField.snp.makeConstraints { make in
            make.top.equalTo(guidePhrase.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        nextButton.addTarget(self, action: #selector(handleCompleteRegistration), for: .touchUpInside)
        codeField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
    }
    
    // MARK: - Logics
    private var isEditingCode: Bool {
        return self.codeField.isEditing
    }
}

extension CheckSecurityCodeController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let maxLength: Int = 12
            
        if text.count >= maxLength && range.length == 0 && range.location <= maxLength {
            return false
        }
        return true
    }
}
