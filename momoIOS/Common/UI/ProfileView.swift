//
//  ProfileView.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/09.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    
    // MARK: - Properties
    var username = "넥스터즈"
    var userJob = "Owner"
    var userYear = 22
    var email = "nexters@naver.com"
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let image = UIImage(named: "profileImage")
        imageView.image = image
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var userBasicInfomationView: UIStackView = {
        let usernameLabel = UILabel()
        let jobLabel = UILabel()
        let jobLabelView = UIView()
        let view = UIStackView(arrangedSubviews: [usernameLabel, jobLabelView])
        view.axis = .horizontal
        view.spacing = 8
        
        usernameLabel.text = username
        usernameLabel.font = .title20
        usernameLabel.textColor = .gray800
        
        jobLabel.text = userJob
        jobLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        jobLabel.textColor = .b400
        jobLabelView.addSubview(jobLabel)
        jobLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(jobLabelView).inset(5)
            make.horizontalEdges.equalTo(jobLabelView).inset(10)
        }
        jobLabelView.backgroundColor = .b100
        jobLabelView.layer.cornerRadius = 8
        
        return view
    }()
    
    private lazy var userAdditionalInformationView: UILabel = {
        let label = UILabel()
        label.text = email
        label.font = .body16
        label.textColor = UIColor.gray600
        return label
    }()
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = .clear
        self.setupLayout()
    }
    
    // MARK: - Helpers
    
    private func setupLayout() {
        self.addSubviews(profileImageView, userBasicInfomationView, userAdditionalInformationView)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.centerX.equalTo(self)
        }
        
        userBasicInfomationView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).inset(10)
            make.centerX.equalTo(self)
        }
        userAdditionalInformationView.snp.makeConstraints { make in
            make.top.equalTo(userBasicInfomationView.snp.bottom).offset(6)
            make.centerX.equalTo(self)
        }
    }
}
