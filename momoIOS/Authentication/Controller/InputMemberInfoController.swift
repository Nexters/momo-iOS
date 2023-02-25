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
    
    private var jobButtonView = UIStackView()
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
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.count > 0 {
            textField.backgroundColor = .textbox2
            textField.layer.borderColor = UIColor.rgba(213, 204, 238, 1).cgColor
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
            completeButton.setTitleColor(UIColor.rgba(255, 255, 255, 0.4), for: .normal)
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
            designerButton.jobLabel.textColor = .rgba(132, 112, 255, 1)
            designerButton.configurate(bgColor: .rgba(237, 234, 255, 1), strokeColor: UIColor.main, strokeWidth: 2, cornerRadius: 8, padding: 0)
            
            developerButton.isSelected = false
            developerButton.jobLabel.textColor = .gray500
            developerButton.configurate(bgColor: .white, strokeColor: .pastbox, strokeWidth: 1, cornerRadius: 8, padding: 0)
        } else { // developer
            developerButton.isSelected = true
            developerButton.configurate(bgColor: .rgba(237, 234, 255, 1), strokeColor: UIColor.main, strokeWidth: 2, cornerRadius: 8, padding: 0)
            developerButton.jobLabel.textColor = .rgba(132, 112, 255, 1)
            
            designerButton.isSelected = false
            designerButton.jobLabel.textColor = .gray500
            designerButton.configurate(bgColor: .white, strokeColor: .pastbox, strokeWidth: 1, cornerRadius: 8, padding: 0)
        }
    }
    
    // MARK: - Helpers
    
    private func setupCustomNav() {
        let navBar = self.navigationController?.navigationBar
        navBar?.isHidden = false
        navBar?.tintColor = .black
        navBar?.backIndicatorImage = UIImage(systemName: "arrow.left")
        navBar?.backIndicatorTransitionMaskImage = UIImage(systemName: "arrow.left")
        navBar?.topItem?.title = ""
        
        let title = UILabel()
        title.text = "회원정보입력"
        self.navigationItem.titleView = title
    }
    
    private func setupJobButtonView() {
        jobButtonView.addArrangedSubviews(designerButton, developerButton)
        jobButtonView.axis = .horizontal
        jobButtonView.spacing = 15
        
        designerButton.addTarget(self, action: #selector(handleJobSelection), for: .touchUpInside)
        developerButton.addTarget(self, action: #selector(handleJobSelection), for: .touchUpInside)
        
        designerButton.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.width.equalTo((view.frame.width - 63) / 2)
        }
        
        developerButton.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.width.equalTo((view.frame.width - 63) / 2)
        }
    }
    
    private func setupLayout() {
        yearTextField.keyboardType = .numberPad
        self.setupJobButtonView()
        view.addSubviews(nameLabel, nameTextField, yearLabel, yearTextField, jobLabel, jobButtonView, completeButton)
        
        completeButton.backgroundColor = .gray600
        completeButton.setTitleColor(UIColor.rgba(255, 255, 255, 0.4), for: .normal)
        completeButton.isEnabled = false
        
        nameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
        yearTextField.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
        nameTextField.addTarget(self, action: #selector(textFieldDidFilled), for: .allEditingEvents)
        yearTextField.addTarget(self, action: #selector(textFieldDidFilled), for: .allEditingEvents)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.left.equalToSuperview().offset(24)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(24)
        }
        
        yearTextField.snp.makeConstraints { make in
            make.top.equalTo(yearLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        jobLabel.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(24)
        }
        
        jobButtonView.snp.makeConstraints { make in
            make.top.equalTo(jobLabel.snp.bottom).offset(14)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}
