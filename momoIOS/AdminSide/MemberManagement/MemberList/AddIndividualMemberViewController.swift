//
//  AddIndividualMemberViewController.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/11.
//

import UIKit
import SnapKit

class AddIndividualMemberViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var titleLabel = CommonTitleLabel(labelText: "회원정보를\n입력하세요.")
    private lazy var nameLabel = setupAreaLabel(text: "이름을 입력해주세요")
    private lazy var nameTextField = CommonTextField(placeholderText: "이름")
    private lazy var emailLabel = setupAreaLabel(text: "메일 주소를 입력해주세요")
    private lazy var emailTextField = CommonTextField(placeholderText: "메일 주소")
    private lazy var addButton = CommonActionButton(buttonTitle: "등록하기   →")
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupCustomNav()
        self.setupLayout()
        
        addButton.backgroundColor = .gray600
        addButton.setTitleColor(UIColor(hex: 0xFFFFFF, alpha: 0.4), for: .normal)
        addButton.isEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    // MARK: - Selectors
    
    @objc private func textFieldDidChanged(_ textField: UITextField) {
        // textfield border 강조
        guard let text = textField.text else { return }
        
        if text.count == 0 {
            textField.layer.borderWidth = 0
            textField.backgroundColor = .textbox1
        } else {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.stroke.cgColor
            textField.backgroundColor = .textbox2
        }
        
        // 등록하기 버튼 enable/disabled
        guard let name = nameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        
        if name.count == 0 || email.count == 0 {
            addButton.backgroundColor = .gray600
            addButton.setTitleColor(UIColor(hex: 0xFFFFFF, alpha: 0.4), for: .normal)
            addButton.isEnabled = false
        } else {
            addButton.backgroundColor = .main
            addButton.setTitleColor(.white, for: .normal)
            addButton.isEnabled = true
        }
    }
    
    // MARK: - Helpers
    
    private func setupCustomNav() {
        // custom nav
        let navBar = self.navigationController?.navigationBar
        // back button (left)
        navBar?.isHidden = false
        navBar?.tintColor = .gray800
        navBar?.backIndicatorImage = UIImage(systemName: "arrow.left")
        navBar?.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
        navBar?.topItem?.title = ""
        
        // title (center)
        let title = UILabel()
        title.text = "회원등록"
        title.textColor = .gray800
        title.font = .body16
        navigationItem.titleView = title
    }
    
    private func setupViews() {
        self.nameTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        self.emailTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        
        self.view.addSubviews(titleLabel, nameLabel, nameTextField, emailLabel, emailTextField, addButton)
    }
    
    private func setupLayout() {
        self.setupViews()
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(27)
            make.leading.equalToSuperview().inset(24)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(136)
            make.leading.equalToSuperview().inset(24)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(25)
            make.leading.equalToSuperview().inset(24)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(18)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
    }
}
