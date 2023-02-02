//
//  RegistrationController.swift
//  momoIOS
//
//  Created by 문다 on 2023/01/30.
//

import UIKit
import SnapKit

class RegistrationController: UIViewController {
    // MARK: - Properties
    
    private lazy var emailTextField: UITextField = {
        return inputContainerView(placeholder: "이메일을 입력해주세요")
    }()
    
    private let validEmailFormatLabel: UILabel = {
        let label = UILabel()
        label.text = "넥스터즈 가입 메일주소를 입력해주세요"
        label.font = .systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        return inputContainerView(placeholder: "비밀번호를 입력해주세요")
    }()
    
    private let validPasswordFormatLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 13)
        label.textColor = .rgba(255, 38, 38, 1)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var checkPasswordTextField: UITextField = {
        return inputContainerView(placeholder: "비밀번호를 재입력해주세요")
    }()
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 13)
        label.textColor = .rgba(255, 38, 38, 1)
        return label
    }()
    
    private let registrationButton: UIButton = {
        return actionButton(title: "가입하기")
    }()
    
    private let pushLoginViewButton: UIButton = {
        return pushAnotherViewButton(subtitle: "이미 가입했다면?", title: "로그인하기")
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTargets()
        configureUI()
        registrationButton.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        pushLoginViewButton.addTarget(self, action: #selector(handlePushLoginView), for: .touchUpInside)
        pushHelpLogin.addTarget(self, action: #selector(handlePushHelpLogin), for: .touchUpInside)
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
                validEmailFormatLabel.text = "넥스터즈 가입 메일주소를 입력해주세요"
                validEmailFormatLabel.textColor = .black
            } else {
                validEmailFormatLabel.text = "이메일 형식을 확인해주세요"
                validEmailFormatLabel.textColor = .rgba(255, 38, 38, 1)
            }
        } else {
            validEmailFormatLabel.text = ""
        }
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9]).{8,20}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegEx).evaluate(with: password)
    }
    
    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        guard let password = textField.text else { return }
        
        if !isValidPassword(password: password) {
            if password.count == 0 {
                confirmPasswordLabel.text = ""
            } else {
                validPasswordFormatLabel.text = "비밀번호 형식을 확인해주세요\n알파벳+숫자 필수 포함, 특수문자 가능 (8~20자)"
            }
        } else {
            validPasswordFormatLabel.text = ""
        }
    }
    
    @objc private func confirmPassword(_ textField: UITextField) {
        guard let password = passwordTextField.text else { return }
        guard let checkPassword = checkPasswordTextField.text else { return }
        
        if password == checkPassword {
            confirmPasswordLabel.text = ""
        } else {
            confirmPasswordLabel.text = "비밀번호가 일치하지 않습니다."
        }
    }
    
    @objc func handleRegistration() {
        let controller = CheckSecurityCodeController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handlePushLoginView() {
        let nav = UINavigationController(rootViewController: LoginController())
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
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
    
    private func setupTargets() {
        emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        checkPasswordTextField.addTarget(self, action: #selector(confirmPassword(_:)), for: .editingChanged)
    }
    
    private func setupEmailContainerView() -> UIStackView {
        return setupUIStackView([emailTextField, validEmailFormatLabel])
    }
    
    private func setupPasswordTextFieldView() -> UIStackView {
        return setupUIStackView([passwordTextField, validPasswordFormatLabel])
    }
    
    private func setupCheckPasswordTextFieldView() -> UIStackView {
        return setupUIStackView([checkPasswordTextField, confirmPasswordLabel])
    }
    
    func configureUI() {
        view.addSubview(welcomeTitle)
        welcomeTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.equalTo(view).offset(20)
        }
        
        let emailContainerView = setupEmailContainerView()
        let passwordContainerView = setupPasswordTextFieldView()
        let checkPasswordContainerView = setupCheckPasswordTextFieldView()

        let fieldStack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, checkPasswordContainerView, registrationButton])
        fieldStack.axis = .vertical
        fieldStack.spacing = 10
        view.addSubview(fieldStack)
        fieldStack.snp.makeConstraints { make in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(20)
        }
        
        let helpStack = UIStackView(arrangedSubviews: [pushLoginViewButton, pushHelpLogin])
        helpStack.axis = .vertical
        helpStack.spacing = 30
        view.addSubview(helpStack)
        helpStack.snp.makeConstraints { make in
            make.top.equalTo(fieldStack.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
