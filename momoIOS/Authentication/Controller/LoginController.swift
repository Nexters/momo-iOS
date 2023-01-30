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
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handlePushRegistrationView() {
    }
    
    @objc func handlePushHelpLogin() {
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(welcomeTitle)
        
        welcomeTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.equalTo(view).offset(20)
        }
        
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stack.axis = .vertical
        stack.spacing = 15
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(50)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(stack.snp.bottom).offset(20)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        view.addSubview(pushRegistrationViewButton)
        pushRegistrationViewButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
        pushRegistrationViewButton.addTarget(self, action: #selector(handlePushRegistrationView), for: .touchUpInside)

        view.addSubview(pushHelpLogin)
        pushHelpLogin.snp.makeConstraints { make in
            make.top.equalTo(pushRegistrationViewButton.snp.bottom).offset(30)
            make.left.right.equalToSuperview()
        }
        pushHelpLogin.addTarget(self, action: #selector(handlePushHelpLogin), for: .touchUpInside)
    }
}

// MARK: - Extension

extension LoginController {
    func inputContainerView(placeholder: String) -> UITextField {
        let tf = UITextField()
        tf.heightAnchor.constraint(equalToConstant: 55).isActive = true
        tf.placeholder = placeholder
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        return tf
    }
}
