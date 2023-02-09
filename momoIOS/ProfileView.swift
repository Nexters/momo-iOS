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
    private let username = "김넥터"
    private let userJob = "designer"
    private let userYear = 22
    private let email = "nexters@naver.com"
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 93, height: 93))
        imageView.image = UIImage(named: "\(userJob)")!
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 93 / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.rgba(208, 208, 208, 1).cgColor
        
        return imageView
    }()
    
    private lazy var userActiveStatus: UIView = {
        let statusView = UIView()
        
        let status = UILabel()
        status.text = "\(userYear)기 참여중"
        status.font = .systemFont(ofSize: 13, weight: .bold)
        status.textColor = .white
        
        statusView.addSubview(status)
        status.snp.makeConstraints { make in
            make.edges.equalTo(statusView).inset(9)
        }
        statusView.backgroundColor = UIColor.rgba(116, 207, 130, 1)
        statusView.layer.cornerRadius = 5
        return statusView
    }()
    
    private lazy var userBasicInfomationView: UIStackView = {
        let usernameLabel = UILabel()
        let jobLabel = UILabel()
        let jobLabelView = UIView()
        let view = UIStackView(arrangedSubviews: [usernameLabel, jobLabelView])
        view.axis = .horizontal
        view.spacing = 10
        
        usernameLabel.text = username
        usernameLabel.font = .systemFont(ofSize: 22, weight: .medium)
        usernameLabel.textColor = .black
        
        jobLabel.text = userJob.uppercased()
        jobLabel.font = .systemFont(ofSize: 13)
        jobLabelView.addSubview(jobLabel)
        jobLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(jobLabelView).inset(5)
            make.horizontalEdges.equalTo(jobLabelView).inset(10)
        }
        jobLabelView.backgroundColor = UIColor.rgba(210, 210, 210, 1)
        
        return view
    }()
    
    private lazy var userAdditionalInformationView: UILabel = {
        let label = UILabel()
        label.text = email
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.rgba(118, 118, 118, 1)
        return label
    }()
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = .white
        self.setupLayout()
    }
    // MARK: - Helpers
    private func setupLayout() {
        self.addSubviews(profileImageView, userActiveStatus, userBasicInfomationView, userAdditionalInformationView)
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(36)
            make.centerX.equalTo(self)
        }
        userActiveStatus.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.centerY).offset(10)
            make.left.equalTo(profileImageView.snp.centerX).offset(10)
        }
        
        userBasicInfomationView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
        }
        userAdditionalInformationView.snp.makeConstraints { make in
            make.top.equalTo(userBasicInfomationView.snp.bottom).offset(10)
            make.centerX.equalTo(self)
        }
    }
}
