//
//  InputMemberInfoController.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/02.
//

import UIKit
import SnapKit

class InputMemberInfoController: UIViewController {
    // MARK: - set Properties
    
    private func setLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }
    
    private func setInputNameView() -> UIView {
        let view = UIView()
        
        let label = setLabel(text: "이름")
        let textField = CommonTextField(placeholderText: "")
        
        view.addSubviews(label, textField)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.right.equalToSuperview()
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(15)
            make.width.equalTo(view)
        }
        return view
    }
    
    private func setInputYearView() -> UIView {
        let view = UIView()
        
        let titleLabel = setLabel(text: "기수")
        let textField = CommonTextField(placeholderText: "")
        let yearLabel = setLabel(text: "기")
        
        view.addSubviews(titleLabel, textField, yearLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
        }
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.left.equalTo(view.snp.left)
            make.width.equalTo(200)
        }
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(textField)
            make.left.equalTo(textField.snp.right).offset(15)
        }
        return view
    }
    
    private lazy var designerButton = setJobButton(jobName: "Designer", width: 200, tag: 1)
    private lazy var developerButton = setJobButton(jobName: "Developer", width: 215, tag: 2)
    
    private func setInputJobView() -> UIView {
        let view = UIView()
        
        let label = setLabel(text: "직군")
        
        view.addSubviews(label, designerButton, developerButton)
        label.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
        }
        designerButton.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(15)
            make.left.equalTo(view.snp.left)
        }
        developerButton.snp.makeConstraints { make in
            make.centerY.equalTo(designerButton)
            make.left.equalTo(designerButton.snp.right).offset(15)
        }
        designerButton.addTarget(self, action: #selector(handleJobSelection), for: .touchUpInside)
        developerButton.addTarget(self, action: #selector(handleJobSelection), for: .touchUpInside)
        return view
    }
    
    private func setJobButton(jobName: String, width: CGFloat, tag: Int) -> UIButton {
        let button = UIButton()
        
        button.setTitle(jobName, for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.contentEdgeInsets = UIEdgeInsets(top: 13, left: 13, bottom: 13, right: 13)
        
        button.frame = CGRect(x: 0, y: 0, width: width, height: 30)
        button.backgroundColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 0.75
        button.layer.borderColor = UIColor.gray.cgColor
        
        button.tag = tag
        return button
    }
    
    private let completeButton = CommonActionButton(buttonTitle: "가입완료!")
    
    // MARK: - Lifecycles
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupCustomNav()
        setupLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
    }
    
    // MARK: - Selectors
    
    @objc private func handleJobSelection(_ selectedButton: UIButton) {
        if selectedButton.tag == 1 { // designer
            designerButton.setTitleColor(.black, for: .normal)
            designerButton.layer.borderColor = UIColor.black.cgColor
            developerButton.setTitleColor(.gray, for: .normal)
            developerButton.layer.borderColor = UIColor.gray.cgColor
        } else { // developer
            designerButton.setTitleColor(.gray, for: .normal)
            designerButton.layer.borderColor = UIColor.gray.cgColor
            developerButton.setTitleColor(.black, for: .normal)
            developerButton.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    // MARK: - Helpers
    
    private func setupCustomNav() {
        let title = UILabel()
        title.text = "회원정보입력"
        self.navigationItem.titleView = title
        self.navigationItem.titleView?.tintColor = .black
    }
    
    private func setupLayout() {
        let inputViews = [setInputNameView(), setInputYearView(), setInputJobView()]
        inputViews.forEach { view in
            view.snp.makeConstraints { make in
                make.height.greaterThanOrEqualTo(100)
            }
        }
        
        let fieldStack = UIStackView(arrangedSubviews: inputViews)
        fieldStack.axis = .vertical
        fieldStack.spacing = 20
        
        view.addSubviews(fieldStack, completeButton)
        fieldStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-50)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}
