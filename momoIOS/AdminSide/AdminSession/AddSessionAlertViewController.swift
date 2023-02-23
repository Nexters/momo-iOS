//
//  AddSessionAlertViewController.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/22.
//

import UIKit
import SnapKit

// MARK: - 어드민 세션 커스텀 Alert 창
class AddSessionAlertViewController: UIViewController {
    let mainView = UIView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let cancelButton = UIButton()
    let confirmButton = UIButton()
    var confirmClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setBaseView()
        self.setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.backgroundColor = .black.withAlphaComponent(0.6)
        }
    }
    
    func setTitleLabel(title: String, description: String, leftBtnTitle: String, rightBtnTitle: String) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.cancelButton.titleLabel?.text = leftBtnTitle
        self.confirmButton.setTitle(rightBtnTitle, size: 18, weight: UIFont.Weight(500), color: .white)
    }
    
    private func setBaseView() {
        self.view.backgroundColor = .clear
        self.view.addSubview(self.mainView)
        
        self.mainView.backgroundColor = .white
        self.mainView.layer.cornerRadius = 20
        self.mainView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        self.mainView.addSubviews(titleLabel, descriptionLabel, cancelButton, confirmButton)
        
        self.titleLabel.font = .systemFont(ofSize: 20, weight: UIFont.Weight(600))
        self.titleLabel.textColor = UIColor(hex: 0x222222)
        self.titleLabel.numberOfLines = 0
        
        self.descriptionLabel.font = .systemFont(ofSize: 16, weight: UIFont.Weight(500))
        self.descriptionLabel.textColor = UIColor(hex: 0x727484)
        self.descriptionLabel.numberOfLines = 0
        
        self.cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        self.cancelButton.setTitle("취소", size: 18, weight: UIFont.Weight(500), color: UIColor(hex: 0x727484))
        self.cancelButton.configurate(bgColor: UIColor(hex: 0xE7E8EC), cornerRadius: 8, padding: 10)
        
        self.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        self.confirmButton.configurate(bgColor: UIColor(hex: 0xFF6464), cornerRadius: 8, padding: 10)
    }
    
    private func setConstraints() {
        self.mainView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(self.titleLabel)
        }
        
        self.cancelButton.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(49)
            make.leading.equalTo(self.descriptionLabel)
            make.height.equalTo(60)
        }
        
        self.confirmButton.snp.makeConstraints { make in
            make.top.equalTo(self.cancelButton)
            make.leading.equalTo(self.cancelButton.snp.trailing).offset(8)
            make.trailing.equalTo(self.descriptionLabel)
            make.size.equalTo(self.cancelButton)
            make.bottom.equalToSuperview().inset(40)
        }
    }
}

// MARK: event 처리 용 extension
extension AddSessionAlertViewController {
    @objc private func didTapCancelButton() {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = .clear
        } completion: { _ in
            self.dismiss(animated: true)
        }
    }
    
    @objc private func didTapConfirmButton() {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = .clear
        } completion: { _ in
            self.dismiss(animated: true, completion: {
                self.confirmClosure?()
            })
        }
    }
}
