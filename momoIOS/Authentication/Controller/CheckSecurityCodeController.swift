//
//  CheckSecurityCodeController.swift
//  momoIOS
//
//  Created by 문다 on 2023/01/30.
//

import UIKit

class CheckSecurityCodeController: UIViewController {
    // MARK: - Properties
    private let guidePhrase: UILabel = {
        let phrase = UILabel()
        phrase.text = "보안코드를\n입력해주세요."
        phrase.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        phrase.numberOfLines = 0
        return phrase
    }()
    
    private let codeField: UITextField = {
        let field = UITextField()
        field.font = UIFont.systemFont(ofSize: 40)
        field.textAlignment = .center
        return field
    }()
    
    private let borderView: UIView = {
        let border = UIView()
        border.backgroundColor = .black
        return border
    }()
    
    private let completeButton: UIButton = {
        return actionButton(title: "가입완료!")
    }()
    
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.addSubview(guidePhrase)
        guidePhrase.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(codeField)
        codeField.snp.makeConstraints { make in
            make.top.equalTo(guidePhrase.snp.bottom).offset(130)
            make.left.right.equalToSuperview().inset(20)
        }
        
        view.addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.top.equalTo(codeField.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(0.75)
        }
        
        view.addSubview(completeButton)
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(20)
        }
    }
}
