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
    
    private lazy var passwordTextField: UITextField = {
        return inputContainerView(placeholder: "비밀번호를 입력해주세요")
    }()
    
    private lazy var checkPasswordTextField: UITextField = {
        return inputContainerView(placeholder: "비밀번호를 재입력해주세요")
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
        configureUI()
        pushLoginViewButton.addTarget(self, action: #selector(handlePushLoginView), for: .touchUpInside)
        pushHelpLogin.addTarget(self, action: #selector(handlePushHelpLogin), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    
    @objc func handlePushLoginView() {
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
        
        let fieldStack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, checkPasswordTextField, registrationButton])
        fieldStack.axis = .vertical
        fieldStack.spacing = 15
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
