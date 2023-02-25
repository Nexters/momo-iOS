//
//  LoginController.swift
//  momoIOS
//
//  Created by 문다 on 2023/01/30.
//

import UIKit
import SnapKit

class LoginController: UIViewController {
    // MARK: - Properties
    
    // logo area
    private lazy var welcomeTitle = CommonTitleLabel(labelText: "간편한 출석체크")
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 139, height: 41))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "MDMY")
        return imageView
    }()
    
    // email area
    private lazy var emailLabel = setupAreaLabel(text: "이메일")
    private lazy var emailTextField = CommonTextField(placeholderText: "넥스터즈 가입 시 메일주소를 입력해주세요")
    private let validEmailFormatLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .warning
        return label
    }()
    
    // password area
    private lazy var passwordLabel = setupAreaLabel(text: "비밀번호")
    private lazy var passwordTextField = CommonTextField(placeholderText: "비밀번호를 입력해주세요", isSecure: true)
    
    // button area
    private let loginButton = CommonActionButton(buttonTitle: "로그인   →")
    private let pushRegistrationViewButton = pushAnotherViewButton(subtitle: "회원가입이 필요한가요?", title: "회원가입")
    private let pushHelpLoginButton = setupPushHelpButton(helpType: "회원가입")
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        passwordTextField.delegate = self
        
        setupLayout()
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        pushRegistrationViewButton.addTarget(self, action: #selector(handlePushRegistrationView), for: .touchUpInside)
        pushHelpLoginButton.addTarget(self, action: #selector(handlePushHelpLogin), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    // MARK: - Selectors
    
    func isValidEmail(email: String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           return NSPredicate(format: "SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    @objc private func emailTextFieldDidChange(_ textField: UITextField) {
        guard let email = textField.text else { return }
        
        if !isValidEmail(email: email) {
            if email.count == 0 {
                validEmailFormatLabel.text = ""
                emailTextField.layer.borderWidth = 0
            } else {
                validEmailFormatLabel.text = "이메일 형식을 확인해주세요"
                emailTextField.layer.borderWidth = 1
                emailTextField.layer.borderColor = UIColor.rgba(241, 90, 80, 1).cgColor
            }
        } else {
            validEmailFormatLabel.text = ""
            emailTextField.layer.borderWidth = 1
            emailTextField.layer.borderColor = UIColor.rgba(213, 204, 238, 1).cgColor
        }
    }
    
    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        guard let password = textField.text else { return }
        
        if password.count == 0 {
            passwordTextField.layer.borderWidth = 0
        } else {
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = UIColor.rgba(213, 204, 238, 1).cgColor
        }
        
    }
    
    @objc func handlePushRegistrationView() {
        self.dismiss(animated: true)
    }
    
    @objc func handlePushHelpLogin() {
        // TODO: 로그인 가이드 url 변경 필요
        guard let url = URL(string: "https://www.google.co.kr/") else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:])
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    // MARK: - Helpers
    
    func setupLayout() {
        
        let emailFieldStack = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        emailFieldStack.axis = .vertical
        emailFieldStack.spacing = 10
        
        let passwordFieldStack = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        passwordFieldStack.axis = .vertical
        passwordFieldStack.spacing = 10
        
        let helpStack = UIStackView(arrangedSubviews: [pushRegistrationViewButton, pushHelpLoginButton])
        helpStack.axis = .vertical
        helpStack.spacing = 40
        
        view.addSubviews(welcomeTitle, logoImage, emailFieldStack, validEmailFormatLabel, passwordFieldStack, loginButton, helpStack)
        
        welcomeTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.equalToSuperview().offset(24)
        }
        
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(22)
        }
        
        emailFieldStack.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(47)
            make.left.right.equalToSuperview().inset(24)
        }
        
        validEmailFormatLabel.snp.makeConstraints { make in
            make.top.equalTo(emailFieldStack.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(29)
        }
        
        passwordFieldStack.snp.makeConstraints { make in
            make.top.equalTo(emailFieldStack.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(24)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordFieldStack.snp.bottom).offset(24)
            make.left.right.equalToSuperview().inset(24)
        }
        
        helpStack.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
}

extension LoginController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let maxLength: Int = 20
            
        if text.count >= maxLength && range.length == 0 && range.location <= maxLength {
            return false
        }
        return true
    }
}
