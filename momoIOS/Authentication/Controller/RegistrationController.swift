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
    
    private let fieldStack = UIStackView()
    private let helpStack = UIStackView()
    
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
    private lazy var checkPasswordTextField = CommonTextField(placeholderText: "비밀번호를 재입력해주세요", isSecure: true)
    private let validPasswordFormatLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 13)
        label.textColor = .rgba(255, 38, 38, 1)
        label.numberOfLines = 0
        return label
    }()
    
    // button area
    private let registrationButton = CommonActionButton(buttonTitle: "가입하기   →")
    private let pushLoginViewButton: UIButton = {
        return pushAnotherViewButton(subtitle: "이미 가입했다면?", title: "로그인하기")
    }()
    private let pushHelpLoginButton = setupPushHelpButton(helpType: "로그인")
    
    // MARK: - Lifecycles
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        passwordTextField.delegate = self
        checkPasswordTextField.delegate = self
        
        self.setupTargets()
        self.setupLayout()
        self.registrationButton.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        self.pushLoginViewButton.addTarget(self, action: #selector(handlePushLoginView), for: .touchUpInside)
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
    
    private func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*[0-9]).{8,20}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegEx).evaluate(with: password)
    }
    
    @objc private func passwordTextFieldDidChange(_ textField: UITextField) {
        guard let password = textField.text else { return }
        validPasswordFormatLabel.text = ""
        
        if password.isEmpty {
            passwordTextField.layer.borderWidth = 0
        } else {
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = UIColor.rgba(213, 204, 238, 1).cgColor
        }
        
        checkPasswordTextField.text?.removeAll()
        checkPasswordTextField.layer.borderWidth = 0
    }
    
    @objc private func checkPasswordTextFieldDidChange(_ textField: UITextField) {
        guard let checkPassword = textField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        if !isValidPassword(password: checkPassword) {
            validPasswordFormatLabel.text = "영문, 숫자를 포함한 8자리 이상 비밀번호를 입력해주세요"
            passwordTextField.layer.borderWidth = 1
            passwordTextField.layer.borderColor = UIColor(red: 241, green: 90, blue: 80, alpha: 1).cgColor
            checkPasswordTextField.layer.borderWidth = 1
            checkPasswordTextField.layer.borderColor = UIColor(red: 241, green: 90, blue: 80, alpha: 1).cgColor
        } else { // valid
            if password == checkPassword {
                validPasswordFormatLabel.text = ""
                passwordTextField.layer.borderWidth = 1
                passwordTextField.layer.borderColor = UIColor.rgba(213, 204, 238, 1).cgColor
                checkPasswordTextField.layer.borderWidth = 1
                checkPasswordTextField.layer.borderColor = UIColor.rgba(213, 204, 238, 1).cgColor
            } else { // but incosistent
                validPasswordFormatLabel.text = "비밀번호가 일치하지 않습니다"
                passwordTextField.layer.borderWidth = 1
                passwordTextField.layer.borderColor = UIColor(red: 241, green: 90, blue: 80, alpha: 1).cgColor
                checkPasswordTextField.layer.borderWidth = 1
                checkPasswordTextField.layer.borderColor = UIColor(red: 241, green: 90, blue: 80, alpha: 1).cgColor
            }
        }
    }
    
    @objc private func handleRegistration() {
        let controller = CheckSecurityCodeController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func handlePushLoginView() {
        let nav = UINavigationController(rootViewController: LoginController())
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc private func handlePushHelpLogin() {
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
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
        checkPasswordTextField.addTarget(self, action: #selector(checkPasswordTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    private func setupEmailContainerView() -> UIStackView {
        return setupUIStackView([emailLabel, emailTextField, validEmailFormatLabel])
    }
    
    private func setupPasswordTextFieldView() -> UIStackView {
        return setupUIStackView([passwordLabel, passwordTextField, checkPasswordTextField, validPasswordFormatLabel])
    }
    
    private func setupViews() {
        let emailContainerView = setupEmailContainerView()
        let passwordContainerView = setupPasswordTextFieldView()
        
        fieldStack.addArrangedSubviews(emailContainerView, passwordContainerView)
        fieldStack.axis = .vertical
        fieldStack.spacing = 10
        
        helpStack.addArrangedSubviews(pushLoginViewButton, pushHelpLoginButton)
        helpStack.axis = .vertical
        helpStack.spacing = 40
        
        view.addSubviews(welcomeTitle, logoImage, fieldStack, registrationButton, helpStack)
    }
    
    private func setupLayout() {
        setupViews()
        
        welcomeTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.equalToSuperview().offset(24)
        }
        
        logoImage.snp.makeConstraints { make in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(22)
        }
        
        fieldStack.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(24)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.top.equalTo(fieldStack.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(24)
        }

        helpStack.snp.makeConstraints { make in
            make.top.equalTo(registrationButton.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
    }
}

extension RegistrationController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let maxLength: Int = 20
            
        if text.count >= maxLength && range.length == 0 && range.location <= maxLength {
            return false
        }
        return true
    }
}
