//
//  AddSessionView.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/18.
//

import UIKit
import SnapKit

// MARK: - 어드민 세션 등록 뷰
class AddSessionView {
    let scrollView = UIScrollView()
    let mainView = UIView()

    let weekLabel = KeyLabel(title: "주차 선택 *")
    let keywordLabel = KeyLabel(title: "대표 타이틀")
    let detailLabel = KeyLabel(title: "대표 정보")
    let timeLabel = KeyLabel(title: "시간 *")
    let placeLabel = KeyLabel(title: "장소")
    let sessionImgLabel = KeyLabel(title: "세부 정보")
    let limitLabel = UILabel()
    let countLabel = UILabel()
    
    let weekBtn = KeyButton(title: "1주차", tintColor: .gray700)
    let keywordTxtField = KeyTextField(placeHolder: "세션을 대표하는 키워드를 입력해주세요")
    let detailTxtField = KeyTextView(placeHolder: "세션을 대표하는 정보를 입력해주세요")
    let dateBtn = KeyButton(title: "날짜")
    let timeBtn = KeyButton(title: "시작시간~종료시간")
    let placeBtn = KeyButton(title: "장소")
    let addressTxtField = KeyTextField(placeHolder: "상세주소를 입력해 주세요")
    
    let downImg = UIImageView(image: UIImage(systemName: "arrowtriangle.down.fill"))
    let rightImg = UIImageView(image: UIImage(systemName: "arrow.right"))
    
    let sessionImgView = UIImageView()
    let sessionImgBtn = UIButton()

    let registerBtn = UIButton()
    
    func initViews(_ superView: UIView) {
        superView.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.contentLayoutGuide.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(900)
        }
        scrollView.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setBaseView()
        setConstraintsTop()
        setConstraintsBottom()
    }
    
    private func setBaseView() {
        mainView.addSubviews(weekLabel, weekBtn, keywordLabel, detailLabel, timeLabel, placeLabel, sessionImgLabel, limitLabel, countLabel, keywordTxtField, detailTxtField, dateBtn, timeBtn, placeBtn, addressTxtField, sessionImgView, sessionImgBtn, registerBtn)
        
        weekBtn.addSubview(downImg)
        downImg.tintColor = .gray700
        
        limitLabel.text = "자/ 300자"
        limitLabel.textColor = .gray500
        limitLabel.font = .body14
        
        countLabel.text = "0"
        countLabel.textColor = .gray500
        countLabel.font = .body14
        
        sessionImgView.contentMode = .scaleAspectFit
        
        placeBtn.addSubview(rightImg)
        rightImg.tintColor = .gray500
        
        sessionImgBtn.setTitle("이미지 추가하기", font: .body18, color: .gray600)
        sessionImgBtn.setImage(UIImage(systemName: "plus.circle.fill"), tintColor: .gray600, padding: 15, direction: .trailing)
        sessionImgBtn.configurate(bgColor: .pastbox, strokeColor: nil, strokeWidth: 0, cornerRadius: 8, padding: 10)
        
        registerBtn.setTitle("등록하기", font: .body18, color: .white)
        registerBtn.configurate(bgColor: .main, strokeColor: nil, strokeWidth: 0, cornerRadius: 8, padding: 10)
        registerBtn.layer.shadowColor = UIColor(hex: 0x3D414F, alpha: 0.6).cgColor
        registerBtn.layer.masksToBounds = false
        registerBtn.layer.shadowOffset = CGSize(width: 0, height: 3)
        registerBtn.layer.shadowOpacity = 0.6
        
        weekBtn.configurate(bgColor: .textbox2, strokeColor: UIColor(hex: 0xD5CCEE), strokeWidth: 1, cornerRadius: 8, padding: 16)
    }
    
    private func setConstraintsTop() {
        downImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(23)
            make.width.equalTo(15)
            make.height.equalTo(12)
        }
        
        weekLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(24)
        }
        
        weekBtn.snp.makeConstraints { make in
            make.top.equalTo(weekLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(52)
        }
        
        keywordLabel.snp.makeConstraints { make in
            make.top.equalTo(weekBtn.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
        }

        keywordTxtField.snp.makeConstraints { make in
            make.top.equalTo(keywordLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(51)
        }

        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(keywordTxtField.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
        }

        detailTxtField.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(51)
        }
        
        limitLabel.snp.makeConstraints { make in
            make.top.equalTo(detailTxtField.snp.bottom).offset(8)
            make.right.equalToSuperview().inset(24)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(limitLabel)
            make.trailing.equalTo(limitLabel.snp.leading)
        }

        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(detailTxtField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(24)
        }
    }
    
    func setConstraintsBottom() {
        dateBtn.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(51)
        }
        
        timeBtn.snp.makeConstraints { make in
            make.top.equalTo(dateBtn.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(51)
        }
        
        placeLabel.snp.makeConstraints { make in
            make.top.equalTo(timeBtn.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(24)
        }
        
        placeBtn.snp.makeConstraints { make in
            make.top.equalTo(placeLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(51)
        }
        
        rightImg.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(23)
            make.size.equalTo(15)
        }
        
        addressTxtField.snp.makeConstraints { make in
            make.top.equalTo(placeBtn.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(51)
        }
        
        sessionImgLabel.snp.makeConstraints { make in
            make.top.equalTo(addressTxtField.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        sessionImgView.snp.makeConstraints { make in
            make.top.equalTo(sessionImgLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(UIScreen.main.bounds.width - 48)
        }
        
        sessionImgBtn.snp.makeConstraints { make in
            make.top.equalTo(sessionImgLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(60)
        }
        
        registerBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(40)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(60)
        }
    }
    
    func setSessionImage(image: UIImage?) {
        scrollView.contentLayoutGuide.snp.updateConstraints { make in
            make.height.equalTo(1270)
        }
        sessionImgView.image = image
        
        sessionImgBtn.snp.remakeConstraints { make in
            make.top.equalTo(sessionImgView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(60)
        }
    }
}

class KeyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("not implement required init?(coder: NSCoder)")
    }

    convenience init(title: String) {
        self.init(frame: .zero)
        
        if title.contains("*") {
            let attrStr = NSMutableAttributedString(string: title)
            attrStr.addAttributes([.font: UIFont.body16, .foregroundColor: UIColor.gray700], range: NSRange(location: 0, length: title.count))
            attrStr.addAttribute(.foregroundColor, value: UIColor.warning, range: (title as NSString).range(of: "*"))
            self.attributedText = attrStr
        } else {
            self.text = title
            self.textColor = .gray700
            self.font = .body16
        }
    }
}

class KeyTextView: UITextView {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.textContainerInset = UIEdgeInsets(top: 20, left: 13, bottom: 20, right: 15)
        self.translatesAutoresizingMaskIntoConstraints = true
        self.sizeToFit()
        self.isScrollEnabled = false
        self.returnKeyType = .done
    }

    required init?(coder: NSCoder) {
        fatalError("not implement required init?(coder: NSCoder)")
    }

    convenience init(placeHolder: String) {
        self.init(frame: .zero)
        
        let str = NSAttributedString(string: placeHolder, attributes: [.font: UIFont.body14, .foregroundColor: UIColor.gray500])
        self.textAlignment = .justified
        self.attributedText = str
        self.backgroundColor =  .textbox1
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor(hex: 0xD5CCEE).cgColor
    }
}

class KeyTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 51))
        self.leftView = paddingView
        self.rightView = paddingView
        self.leftViewMode = .always
        self.rightViewMode = .always
        self.returnKeyType = .done
    }

    required init?(coder: NSCoder) {
        fatalError("not implement required init?(coder: NSCoder)")
    }

    convenience init(placeHolder: String) {
        self.init(frame: .zero)
        
        let str = NSAttributedString(string: placeHolder, attributes: [.font: UIFont.body14, .foregroundColor: UIColor.gray500])
        self.textAlignment = .left
        self.attributedPlaceholder = str
        self.textColor = .gray700
        self.font = .body14
        self.backgroundColor = .textbox1
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor(hex: 0xD5CCEE).cgColor
        self.addTarget(self, action: #selector(didTFChanged), for: .editingChanged)
    }
    
    @objc func didTFChanged(_ sender: UITextField) {
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.layer.borderWidth = 1
            self.backgroundColor = .textbox2
        })
    }
}

class KeyButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("not implement required init?(coder: NSCoder)")
    }

    convenience init(title: String, tintColor: UIColor = .gray500) {
        self.init(frame: .zero)

        self.setTitle(title, font: .body14, color: tintColor)
        self.configurate(bgColor: .textbox1, strokeColor: UIColor(hex: 0xD5CCEE), strokeWidth: 0, cornerRadius: 8, padding: 16)
        self.contentHorizontalAlignment = .left
    }
    
    func setBorderAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0, animations: {
            self.configurate(bgColor: .textbox2, strokeColor: UIColor(hex: 0xD5CCEE), strokeWidth: 1, cornerRadius: 8, padding: 16)
        })
    }
}
