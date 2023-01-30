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
    
    private let welcomeTitle: UILabel = {
        let title = UILabel()
        title.text = "간단한 출석체크,\n모두모여에서"
        title.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var emailTextField: UITextField = {
        return inputContainerView(placeholder: "이메일을 입력해주세요")
    }()
    
    private lazy var passwordTextField: UITextField = {
        return inputContainerView(placeholder: "비밀번호를 입력해주세요")
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .black
        button.heightAnchor.constraint(equalToConstant: 55).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return button
    }()
    
    private let pushRegistrationViewButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(
            string: "회원가입이 필요하다면?",
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                         NSAttributedString.Key.foregroundColor: UIColor.gray])
        attributedTitle.append(NSAttributedString(
            string: "  가입하기",
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                         NSAttributedString.Key.foregroundColor: UIColor.black]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    private let pushHelpLogin: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(
            string: "로그인에 문제가 있나요?",
            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                         NSAttributedString.Key.foregroundColor: UIColor.gray])
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        pushRegistrationViewButton.addTarget(self, action: #selector(handlePushRegistrationView), for: .touchUpInside)
        pushHelpLogin.addTarget(self, action: #selector(handlePushHelpLogin), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    
    @objc func handlePushRegistrationView() {
    }
    
    @objc func handlePushHelpLogin() {
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.addSubview(welcomeTitle)
        welcomeTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.equalTo(view).offset(20)
        }
        
        let fieldStack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        fieldStack.axis = .vertical
        fieldStack.spacing = 15
        view.addSubview(fieldStack)
        fieldStack.snp.makeConstraints { make in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(20)
        }
        
        let helpStack = UIStackView(arrangedSubviews: [pushRegistrationViewButton, pushHelpLogin])
        helpStack.axis = .vertical
        helpStack.spacing = 30
        view.addSubview(helpStack)
        helpStack.snp.makeConstraints { make in
            make.top.equalTo(fieldStack.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}

// MARK: - Extension

extension LoginController {
    func inputContainerView(placeholder: String) -> UITextField {
        let textfield = UITextField()
        textfield.heightAnchor.constraint(equalToConstant: 55).isActive = true
        textfield.placeholder = placeholder
        textfield.borderStyle = .roundedRect
        textfield.font = UIFont.systemFont(ofSize: 16)
        textfield.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return textfield
    }
}
