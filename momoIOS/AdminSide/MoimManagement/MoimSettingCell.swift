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
        label.font = .body16
        label.textColor = .gray800
        return label
    }()
    
    lazy var settingSubtitle: UILabel = {
        let label = UILabel()
        label.text = "→"
        label.font = .body16
        label.textColor = .gray600
        return label
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
        contentView.addSubviews(settingTitle, settingSubtitle)
        
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        settingTitle.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).offset(20)
            make.height.equalTo(contentView)
        }
        
        settingSubtitle.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(20)
//            make.height.equalTo(contentView)
        }
    }
}
