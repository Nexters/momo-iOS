//
//  AttendanceCodeDetailViewController.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/09.
//

import UIKit

class AttendanceCodeDetailViewController: UIViewController {
    private let backgroundView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let codeContainerView: UIStackView = UIStackView()
    private let codeTextFields: [UITextField] = [UITextField(), UITextField(), UITextField(), UITextField()]
    private let descriptionLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.setupNavigation()
    }
    
    // MARK: - Setup
    private func setupNavigation() {
        
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        
        self.backgroundView.backgroundColor = .rgba(128, 135, 201, 1)
        self.backgroundView.layer.cornerRadius = 12
        
        self.titleLabel.text = "출석체크 코드 입력"
        self.titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        self.titleLabel.textColor = .white
        
        self.codeContainerView.axis = .horizontal
        self.codeContainerView.spacing = 14
        self.codeContainerView.distribution = .fillEqually
        
        self.codeTextFields.forEach { textField in
            textField.backgroundColor = .clear
            textField.textAlignment = .center
            textField.textColor = .white
            textField.font = .systemFont(ofSize: 32, weight: .medium)
            textField.keyboardType = .numberPad
//            textField.delegate = self
//            textField.dataSource = self
        }
        
        self.descriptionLabel.text = "운영진이 공지해준 출석체크 코드를 입력해주세요!"
        self.descriptionLabel.font = .systemFont(ofSize: 12)
        self.descriptionLabel.textColor = .white.withAlphaComponent(0.67)
        self.backgroundView.addSubview(self.descriptionLabel)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        self.view.addSubview(self.backgroundView)
        self.backgroundView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(30)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(24)
        }
        
        self.backgroundView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35)
            make.centerX.equalToSuperview()
        }
        
        self.backgroundView.addSubview(self.codeContainerView)
        self.codeContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(54)
            make.leading.trailing.equalToSuperview().inset(53)
        }
        
        self.codeTextFields.forEach { textField in
            let codeView = UIStackView()
            codeView.axis = .vertical
            let view = UIView()
            view.backgroundColor = .white
            
            codeView.addArrangedSubviews(textField, view)
            textField.snp.makeConstraints { make in
                make.width.equalTo(45)
                make.height.equalTo(70)
            }
            view.snp.makeConstraints { make in
                make.width.equalTo(textField)
                make.height.equalTo(1)
            }
            
            self.codeContainerView.addArrangedSubview(codeView)
        }
        self.backgroundView.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.codeContainerView.snp.bottom).offset(33)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(42)
        }
    }
}
