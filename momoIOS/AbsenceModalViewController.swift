//
//  AbsenceModalViewController.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/01.
//

import UIKit
import SnapKit

class AbsenceModalViewController: UIViewController {
    private let contentView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let cancelButton: UIButton = UIButton()
    private let confirmButton: UIButton = UIButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupLayout()
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
    
    // MARK: - Setup
    private func setupViews() {
        self.view.backgroundColor = .clear
        self.setupContentView()
        self.setupTitleLabel()
        self.setupDescriptionLabel()
        self.setupCancelButton()
        self.setupConfirmButton()
    }
    
    private func setupContentView() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        self.view.addSubview(self.contentView)        
    }
    
    private func setupTitleLabel() {
        self.titleLabel.text = "넥스터즈 1주차 세션에 참여하지 못하시나요?"
        self.titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        self.titleLabel.textColor = .rgba(74, 74, 74, 1)
        self.titleLabel.numberOfLines = 0
        self.contentView.addSubview(self.titleLabel)
    }
    
    private func setupDescriptionLabel() {
        self.descriptionLabel.text = "불참사실은 운영진에게 전달되고 활동점수에서 -10점이 차감됩니다."
        self.descriptionLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        self.descriptionLabel.textColor = .rgba(99, 99, 99, 1)
        self.descriptionLabel.numberOfLines = 0
        self.contentView.addSubview(self.descriptionLabel)
    }
    
    private func setupCancelButton() {
        self.cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        self.cancelButton.setTitle("취소", size: 16, weight: .bold, color: .rgba(55, 55, 55, 1))
        self.cancelButton.configurate(bgColor: .white, strokeColor: .rgba(201, 201, 201, 1), strokeWidth: 1, cornerRadius: 7, padding: 10)
        self.contentView.addSubview(self.cancelButton)
    }
    
    private func setupConfirmButton() {
        self.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
        self.confirmButton.setTitle("네, 불참합니다", size: 16, weight: .bold, color: .white)
        self.confirmButton.configurate(bgColor: .rgba(246, 80, 80, 1), cornerRadius: 7, padding: 10)
        self.contentView.addSubview(self.confirmButton)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        self.contentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(39)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(7)
            make.leading.trailing.equalTo(self.titleLabel)
        }
        
        self.cancelButton.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.descriptionLabel)
            make.height.equalTo(52)
        }
        
        self.confirmButton.snp.makeConstraints { make in
            make.top.equalTo(self.cancelButton)
            make.leading.equalTo(self.cancelButton.snp.trailing).offset(8)
            make.trailing.equalTo(self.descriptionLabel)
            make.size.equalTo(self.cancelButton)
            make.bottom.equalToSuperview().inset(42)
        }
    }
    
    // MARK: - Actions
    @objc private func didTapCancelButton() {
        self.closeModal()
    }
    
    @objc private func didTapConfirmButton() {
        self.closeModal()
    }
    
    private func closeModal() {
        self.view.backgroundColor = .clear
        self.dismiss(animated: true)
    }
}
