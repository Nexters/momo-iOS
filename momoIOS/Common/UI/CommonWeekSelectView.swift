//
//  CommonWeekSelectView.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/25.
//

import UIKit
import SnapKit

// MARK: - 커스텀 주차 선택 button
class CommonWeekSelectButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setButtonSettings()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setButtonSettings()
    }

    private func setButtonSettings() {
        self.contentHorizontalAlignment = .left
        self.setTitle("1주차", font: .body14, color: .gray700)
        self.configurate(bgColor: .textbox2, strokeColor: .stroke, strokeWidth: 1, cornerRadius: 8, padding: 10)
        
        let downImg = UIImageView(image: UIImage(systemName: "arrowtriangle.down.fill"))
        self.addSubview(downImg)
        downImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(23)
            make.width.equalTo(15)
            make.height.equalTo(12)
        }
        downImg.tintColor = .gray700
    }
    
    func setWeekText(_ week: Int) {
        self.setTitle("\(week)주차", font: .body14, color: .gray700)
    }
}

// MARK: - 커스텀 주차 선택 sheet view
class CustomWeekSelectSheet: UIView {
    var selectClosure: ((Int) -> Void)?
    var weekBtn = [CustomWeekSelectButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for week in 1..<8 {
            weekBtn.append(CustomWeekSelectButton(week: week))
        }
        weekBtn.append(CustomWeekSelectButton(week: 8, hasBottomLine: false))
        
        weekBtn.forEach({
            $0.addTarget(self, action: #selector(didSelectWeek), for: .touchUpInside)
            self.addSubview($0)
        })
        setBaseView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBaseView() {
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.pastbox.cgColor
        self.isHidden = true
        
        weekBtn[0].snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(52)
        }
        
        for idx in 1..<8 {
            weekBtn[idx].snp.makeConstraints { make in
                make.top.equalTo(weekBtn[idx - 1].snp.bottom)
                make.horizontalEdges.equalToSuperview()
                make.height.equalTo(52)
            }
        }
    }
    
    @objc func didSelectWeek(_ sender: UIButton) {
        self.selectClosure?(sender.tag)
        self.isHidden = true
    }
}

// MARK: - 커스텀 주차 button
class CustomWeekSelectButton: UIButton {
    let bottomLine = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(week: Int, hasBottomLine: Bool = true) {
        self.init(frame: .zero)
        
        self.tag = week
        self.backgroundColor = .textbox1
        self.contentHorizontalAlignment = .leading
        self.setTitle("\(week)주차", font: .body14, color: .gray700)
        if hasBottomLine {
            self.addSubview(bottomLine)
            self.bottomLine.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.height.equalTo(1)
                make.horizontalEdges.equalToSuperview()
            }
            self.bottomLine.backgroundColor = .pastbox
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
