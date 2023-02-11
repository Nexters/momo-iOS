//
//  AddIndividualMemberViewController.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/11.
//

import UIKit
import SnapKit

class AddIndividualMemberViewcontroller: UIViewController {
    
    // MARK: - Properties
    
    private lazy var titleLabel = CommonTitleLabel(labelText: "회원정보를\n입력하세요.")
    private lazy var nameTextField = CommonTextField(placeholderText: "이름")
    private lazy var emailTextField = CommonTextField(placeholderText: "메일 주소")
    private lazy var addButton = CommonActionButton(buttonTitle: "등록하기")
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupCustomNav()
        self.setupLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    // MARK: - Helpers
    
    private func setupCustomNav() {
        // custom nav
        let navBar = self.navigationController?.navigationBar
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .rgba(24, 24, 24, 0.16)
        appearance.backgroundColor = .white
        navBar?.scrollEdgeAppearance = appearance
        navBar?.tintColor = .black
        
        // back button (left)
        self.navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: nil)
        
        // title (center)
        let title = UILabel()
        title.text = "회원등록"
        title.textColor = .black
        title.font = .systemFont(ofSize: 15, weight: .semibold)
        navigationItem.titleView = title
    }
    
    private func setupViews() {
        self.view.addSubviews(titleLabel, nameTextField, emailTextField, addButton)
    }
    
    private func setupLayout() {
        self.setupViews()
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(70)
            make.left.right.equalTo(view).offset(20)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(55)
            make.left.right.equalToSuperview().inset(20)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
