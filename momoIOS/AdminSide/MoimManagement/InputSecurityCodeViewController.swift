//
//  InputSecurityCodeViewController.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/13.
//

import UIKit
import SnapKit

class InputSecurityCodeViewController: UIViewController {
    
    // MARK: - Properties
    
    // private let codeRegEx = "[A-Za-z0-9]{6,12}"
    
    private var isEditingCode: Bool {
        return self.codeField.isEditing
    }
    
    private lazy var titleLabel = CommonTitleLabel(labelText: "보안코드를\n등록해주세요")
    private lazy var guideLabel: UILabel = {
        let label = UILabel()
        label.text = "회원들이 가입시 등록할 코드를 정해주세요."
        label.font = .body16
        label.textColor = .gray600
        return label
    }()
    private let codeField = CommonTextField(placeholderText: "")
    private lazy var nextButton = CommonActionButton(buttonTitle: "확인")
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.codeField.delegate = self
        self.setupKeyboardNotifications()
        self.setupCustomNav()
        self.setupLayout()
        self.setupAction()
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
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        codeField.backgroundColor = UIColor.textbox2
        codeField.layer.borderWidth = 1
        codeField.layer.borderColor = UIColor.stroke.cgColor
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        codeField.backgroundColor = .textbox1
        codeField.layer.borderWidth = 0
    }
    
    // MARK: - Helpers
    
    private func setupAction() {
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
        navBar?.tintColor = .black
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
        view.addSubviews(titleLabel, guideLabel, codeField, nextButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(27)
            make.leading.equalToSuperview().inset(24)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(115)
            make.leading.equalToSuperview().inset(24)
        }
        
        codeField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(24)
            make.top.equalTo(guideLabel.snp.bottom).offset(31)
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
    }
}

extension InputSecurityCodeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let maxLength: Int = 12
            
        if text.count >= maxLength && range.length == 0 && range.location <= maxLength {
            return false
        }
        return true
    }
}
