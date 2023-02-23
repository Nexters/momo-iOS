//
//  MoimSettingCell.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/09.
//

import UIKit
import SnapKit

class MoimSettingCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let id = "MoimSettingCell"
    
    lazy var settingTitle: UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray800
        return label
    }()
    
    private let arrow: UIImageView = {
        let imageView = UIImageView()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 13, weight: .bold)
        let image = UIImage(systemName: "arrow.right", withConfiguration: imageConfig)
        imageView.image = image
        imageView.tintColor = .rgba(159, 159, 159, 1)
        return imageView
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: MoimSettingCell.id)
        self.setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupCell()
    }
    
    // MARK: - Helpers
    
    private func setupCell() {
        contentView.backgroundColor = .white
        contentView.addSubviews(settingTitle, arrow)
        
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.greaterThanOrEqualTo(50)
        }
        
        settingTitle.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(20)
            make.height.equalTo(contentView)
        }
        
        arrow.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(20)
//            make.height.equalTo(contentView)
        }
    }
}
