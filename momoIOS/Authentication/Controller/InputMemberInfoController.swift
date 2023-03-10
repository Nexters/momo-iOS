//
//  InputMemberInfoController.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/02.
//

import UIKit
import SnapKit

class InputMemberInfoController: UIViewController {
    // MARK: - Properties
    
    // name area
    let nameLabel = setupAreaLabel(text: "이름을 입력해주세요")
    private lazy var nameTextField = CommonTextField(placeholderText: "이름")
    
    // year area
    let yearLabel = setupAreaLabel(text: "가입 기수를 입력해주세요")
    private lazy var yearTextField = CommonTextField(placeholderText: "가입 기수")
    
    // job area
    let jobLabel = setupAreaLabel(text: "직군을 선택해주세요")
    private lazy var designerButton = JobButtonView(frame: .zero, jobName: "Designer", jobTag: 1)
    private lazy var developerButton = JobButtonView(frame: .zero, jobName: "Developer", jobTag: 2)
    
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
    @objc func textFieldDidChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.count > 0 {
            textField.backgroundColor = .textbox2
            textField.layer.borderColor = UIColor(hex: 0xD5CCEE).cgColor
            textField.layer.borderWidth = 1
        } else {
            textField.backgroundColor = .textbox1
            textField.layer.borderWidth = 0
        }
    }
    
    @objc func textFieldDidFilled(_ textField: UITextField) {
        guard let name = nameTextField.text else { return }
        guard let year = yearTextField.text else { return }
        
        if name.count == 0 || year.count == 0 {
            completeButton.backgroundColor = .gray600
            completeButton.setTitleColor(UIColor(hex: 0xFFFFFF, alpha: 0.4), for: .normal)
            completeButton.isEnabled = false
        } else {
            completeButton.backgroundColor = .main
            completeButton.setTitleColor(.white, for: .normal)
            completeButton.isEnabled = true
        }
    }
    
    @objc private func handleJobSelection(_ sender: Any) {
        guard let selectedJob = sender as? JobButtonView else { return }
        
        if selectedJob.jobTag == 1 { // designer
            designerButton.isSelected = true
            designerButton.jobLabel.textColor = .main
            designerButton.configurate(bgColor: .p100, strokeColor: UIColor.main, strokeWidth: 2, cornerRadius: 8, padding: 0)
            
            developerButton.isSelected = false
            developerButton.jobLabel.textColor = .gray500
            developerButton.configurate(bgColor: .white, strokeColor: .pastbox, strokeWidth: 1, cornerRadius: 8, padding: 0)
        } else { // developer
            developerButton.isSelected = true
            developerButton.jobLabel.textColor = .main
            developerButton.configurate(bgColor: .p100, strokeColor: UIColor.main, strokeWidth: 2, cornerRadius: 8, padding: 0)
            
            designerButton.isSelected = false
            designerButton.jobLabel.textColor = .gray500
            designerButton.configurate(bgColor: .white, strokeColor: .pastbox, strokeWidth: 1, cornerRadius: 8, padding: 0)
        }
    }
    
    // MARK: - Helpers
    
    private func setupCustomNav() {
        let navBar = self.navigationController?.navigationBar
        navBar?.isHidden = false
        navBar?.tintColor = .gray800
        navBar?.backIndicatorImage = UIImage(systemName: "arrow.left")
        navBar?.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
        navBar?.topItem?.title = ""
        
        let title = UILabel()
        title.text = "회원정보입력"
        title.font = .body16
        title.textColor = .gray800
        self.navigationItem.titleView = title
    }
    
    private func setupViews() {
        
        designerButton.addTarget(self, action: #selector(handleJobSelection), for: .touchUpInside)
        developerButton.addTarget(self, action: #selector(handleJobSelection), for: .touchUpInside)
        
        yearTextField.keyboardType = .numberPad
        view.addSubviews(nameLabel, nameTextField, yearLabel, yearTextField, jobLabel, designerButton, developerButton, completeButton)
        
        completeButton.backgroundColor = .gray600
        completeButton.setTitleColor(UIColor(hex: 0xFFFFFF, alpha: 0.4), for: .normal)
        completeButton.isEnabled = false
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        yearTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(textFieldDidFilled), for: .editingChanged)
        yearTextField.addTarget(self, action: #selector(textFieldDidFilled), for: .editingChanged)
    }
    
    private func setupLayout() {
        setupViews()
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.leading.equalToSuperview().offset(24)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(25)
            make.leading.equalToSuperview().offset(24)
        }
        
        yearTextField.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        jobLabel.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
        }
        
        designerButton.snp.makeConstraints { make in
            make.top.equalTo(jobLabel.snp.bottom).offset(14)
            make.leading.equalToSuperview().inset(24)
            make.height.equalTo(180)
        }
                
        developerButton.snp.makeConstraints { make in
            make.top.size.equalTo(designerButton)
            make.leading.equalTo(designerButton.snp.trailing).offset(15)
            make.trailing.equalToSuperview().inset(24)
        }
        
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(50)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}
