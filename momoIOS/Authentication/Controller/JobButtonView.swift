//
//  JobButtonView.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/25.
//

import UIKit

class JobButtonView: UIButton {
    
    // MARK: - Properties
    var jobTag: Int?
    
    lazy var jobLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .gray500
        label.font = .body16
        return label
    }()
    
    lazy var jobImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        return imageView
    }()
    
    // MARK: - Lifecycles
    
    init(frame: CGRect, jobName: String, jobTag: Int) {
        super.init(frame: frame)
        self.jobTag = jobTag
        jobLabel.text = jobName
        jobLabel.textColor = jobTag == 1 ? .main : .gray500
        jobImageView.image = UIImage(named: jobName.lowercased())
        
        self.layer.masksToBounds = true
        self.configurate(bgColor: jobTag == 1 ? UIColor.p100 : .white,
                         strokeColor: jobTag == 1 ? .main : .pastbox,
                         strokeWidth: jobTag == 1 ? 2 : 1,
                         cornerRadius: 8,
                         padding: 0)
        
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = .white
        self.setupLayout()
    }
    
    // MARK: - Helpers
    
    private func setupLayout() {
        self.addSubviews(jobLabel, jobImageView)
        jobImageView.isUserInteractionEnabled = false
        jobLabel.isUserInteractionEnabled = false
        
        jobImageView.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.top.equalTo(self.snp.top).offset(33)
            make.centerX.equalTo(self)
        }

        jobLabel.snp.makeConstraints { make in
            make.top.equalTo(jobImageView.snp.bottom).offset(20)
            make.centerX.equalTo(self)
            make.bottom.equalTo(self.snp.bottom).inset(28)
        }
    }
}
