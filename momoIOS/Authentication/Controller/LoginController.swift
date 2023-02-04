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
    
    private lazy var welcomeTitle = CommonTitleLabel(labelText: "간단한 출석체크,\n모두모여에서")
    private lazy var emailTextField = CommonTextField(placeholderText: "이메일을 입력해주세요")
    private lazy var passwordTextField = CommonTextField(placeholderText: "비밀번호를 입력해주세요", isSecure: true)
    
    private let loginButton = CommonActionButton(buttonTitle: "로그인")
    
    private let pushRegistrationViewButton: UIButton = {
        return pushAnotherViewButton(subtitle: "회원가입이 필요하다면?", title: "가입하기")
    }()
    
    private let pushHelpLoginButton = setupPushHelpLoginButton()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        pushRegistrationViewButton.addTarget(self, action: #selector(handlePushRegistrationView), for: .touchUpInside)
        pushHelpLoginButton.addTarget(self, action: #selector(handlePushHelpLogin), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    // MARK: - Selectors
    
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
        let fieldStack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        fieldStack.axis = .vertical
        fieldStack.spacing = 15
        
        let helpStack = UIStackView(arrangedSubviews: [pushRegistrationViewButton, pushHelpLoginButton])
        helpStack.axis = .vertical
        helpStack.spacing = 30
        
        view.addSubviews(welcomeTitle, fieldStack, helpStack)
        
        welcomeTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.equalTo(view).offset(20)
        }
        
        fieldStack.snp.makeConstraints { make in
            make.top.equalTo(welcomeTitle.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(20)
        }
        
        helpStack.snp.makeConstraints { make in
            make.top.equalTo(fieldStack.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
