//
//  CommonBottomAlert.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/25.
//

import UIKit

final class CommonBottomAlert: UIViewController {
    private let contentView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let cancelButton: UIButton = UIButton()
    private let confirmButton: UIButton = UIButton()
    
    private var cancelCompletion: (() -> Void)?
    private var confirmCompletion: (() -> Void)?
    
    // MARK: - Create
    func configure(
        title: String? = nil,
        description: String? = nil,
        cancelTitle: String = "취소",
        confirmTitle: String = "확인",
        cancelCompletion: (() -> Void)? = nil,
        confirmCompletion: (() -> Void)? = nil
    ) {
        self.setupTitleLabel(text: title)
        self.setupDescriptionLabel(text: description)
        self.setupCancelButton(title: cancelTitle)
        self.setupConfirmButton(title: confirmTitle)
        self.cancelCompletion = cancelCompletion
        self.confirmCompletion = confirmCompletion
    }
    
    /// 불참 버튼 눌렀을 때 나오는 alert
    ///  - 넥스터즈 1주차 세션에 참여하지 못하시나요?
    ///  - 불참사실은 운영진에게 전달되고 활동점수에서 -10점이 차감됩니다.
    ///  - 취소
    ///  - 네, 불참합니다.
    static func absenceConfirmAlert(confirmCompletion: (() -> Void)? = nil) -> CommonBottomAlert {
        let alert = CommonBottomAlert()
        alert.configure(
            title: "넥스터즈 세션 참여가 어려운가요?",
            description: "불참사실은 운영진에게 전달되고 활동점수에서 -10점이 차감됩니다.",
            cancelTitle: "취소",
            confirmTitle: "네, 불참합니다",
            cancelCompletion: nil,
            confirmCompletion: confirmCompletion
        )
        return alert
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupLayout()
        
        self.cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        self.confirmButton.addTarget(self, action: #selector(didTapConfirmButton), for: .touchUpInside)
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
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    private func setupTitleLabel(text: String? = nil) {
        self.titleLabel.text = text
        self.titleLabel.font = .title20
        self.titleLabel.textColor = .gray800
        self.titleLabel.numberOfLines = 0
    }
    
    private func setupDescriptionLabel(text: String? = nil) {
        self.descriptionLabel.text = text
        self.descriptionLabel.font = .body16
        self.descriptionLabel.textColor = .gray600
        self.descriptionLabel.numberOfLines = 0
    }
    
    private func setupCancelButton(title: String = "취소") {
        self.cancelButton.setTitle(title, font: .body18, color: .gray600)
        self.cancelButton.configurate(
            bgColor: .pastbox,
            cornerRadius: 8,
            edgeInsets: .init(top: 18, leading: 10, bottom: 18, trailing: 10)
        )
    }
    
    private func setupConfirmButton(title: String = "확인") {
        self.confirmButton.setTitle(title, font: .body18, color: .white)
        self.confirmButton.configurate(
            bgColor: .warning,
            cornerRadius: 8,
            edgeInsets: .init(top: 18, leading: 10, bottom: 18, trailing: 10)
        )
    }
    
    // MARK: - Layout
    private func setupLayout() {
        self.view.addSubview(self.contentView)
        self.contentView.addSubviews(self.titleLabel, self.descriptionLabel, self.cancelButton, self.confirmButton)
        
        self.contentView.snp.makeConstraints { make in
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
    
    // MARK: - Actions
    @objc private func didTapCancelButton() {
        self.close {
            self.cancelCompletion?()
        }
    }
    
    @objc private func didTapConfirmButton() {
        self.close {
            self.confirmCompletion?()
        }
    }
    
    func show() {
        guard let topViewController = UIApplication.topViewController() else { return }
        self.modalPresentationStyle = .overFullScreen
        topViewController.present(self, animated: true)
    }
    
    private func close(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view.backgroundColor = .clear
        } completion: { _ in
            self.dismiss(animated: true) {
                completion?()
            }
        }
    }
}
