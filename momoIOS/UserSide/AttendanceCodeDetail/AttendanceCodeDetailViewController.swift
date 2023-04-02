//
//  AttendanceCodeDetailViewController.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/09.
//

import Toast
import UIKit

class AttendanceCodeDetailViewController: UIViewController {
    private let backgroundView: UIImageView = UIImageView(image: UIImage(named: "gradi_light"))
    private let lockImageView: UIImageView = UIImageView(image: UIImage(named: "lock"))
    private let titleLabel: UILabel = UILabel()
    private let codeContainerView: UIStackView = UIStackView()
    private let codeTextFields: [UITextField] = [UITextField(), UITextField(), UITextField(), UITextField()]
    private let descriptionLabel: UILabel = UILabel()
    private let indicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.setupLayout()
        self.codeTextFields.first?.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.setupNavigation()
    }
    
    // MARK: - Setup
    private func setupNavigation() {
        let backButtonImage = UIImage(systemName: "arrow.left")
        let backBarButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(popViewController))
        self.navigationItem.leftBarButtonItem = backBarButton
            
        let titleLabel = UILabel()
        titleLabel.text = "서울특별시 강남구 역삼로"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 14)
        self.navigationItem.titleView = titleLabel
    }
    
    private func setupViews() {
        self.view.backgroundColor = .white
        self.lockImageView.contentMode = .scaleAspectFit
        
        self.titleLabel.text = "출석체크 코드 입력"
        self.titleLabel.font = .pretendard(size: 24, weight: .w600)
        self.titleLabel.textColor = .white
        
        self.descriptionLabel.text = "운영진이 공지해준 출석체크 코드를 입력해주세요!"
        self.descriptionLabel.font = .body16
        self.descriptionLabel.textColor = .init(white: 1, alpha: 0.8)
        
        self.codeContainerView.axis = .horizontal
        self.codeContainerView.alignment = .center
        self.codeContainerView.spacing = 14
        self.codeContainerView.distribution = .fillEqually
        
        self.codeTextFields.forEach { textField in
            textField.backgroundColor = .clear
            textField.textAlignment = .center
            textField.textColor = .white
            textField.font = .systemFont(ofSize: 32, weight: .medium)
            textField.keyboardType = .numberPad
            textField.delegate = self
        }
        self.stopLoadingIndicator()
    }
    
    // MARK: - Layout
    private func setupLayout() {
        self.view.addSubview(self.backgroundView)
        self.backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.view.addSubview(self.lockImageView)
        let screenWidth = UIScreen.main.bounds.width
        self.lockImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            make.leading.equalToSuperview().inset(143/375 * screenWidth)
            make.trailing.equalToSuperview().inset(83/375 * screenWidth)
            make.width.equalTo(148/375 * screenWidth)
            make.height.equalTo(107/375 * screenWidth)
        }
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.lockImageView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(self.codeContainerView)
        self.codeContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.descriptionLabel.snp.bottom).offset(28)
            make.centerX.equalToSuperview()
        }
        
        self.codeTextFields.forEach { textField in
            let boxView = UIView()
            boxView.layer.backgroundColor = UIColor.init(white: 1, alpha: 0.1).cgColor
            boxView.layer.cornerRadius = 8
            boxView.layer.borderWidth = 1
            boxView.layer.borderColor = UIColor.init(white: 1, alpha: 0.5).cgColor
            
            self.codeContainerView.addArrangedSubview(boxView)
            boxView.snp.makeConstraints { make in
                make.width.equalTo(56)
                make.height.equalTo(68)
            }
            
            boxView.addSubview(textField)
            textField.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        self.view.addSubview(self.indicatorView)
        self.indicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc private func didTapAttendButton() {
        self.popViewController()
    }
    
    private func requestCodeIfNeeded() {
        // 4자리 코드 충족되었는 지 확인
        for textField in self.codeTextFields where textField.text.isEmptyOrNil {
            return
        }
        
        self.view.endEditing(true)
        self.startLoadingIndicator()
        
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000) // request
            self.stopLoadingIndicator()
            self.clearAllTextField()
            
            // [success]
//            self.popViewController()
            
            // [fail]
            var toastStyle = ToastStyle()
            toastStyle.backgroundColor = .warning
            toastStyle.cornerRadius = 0
            let point = CGPoint(x: self.view.frame.width / 2, y: 500)
            self.view.makeToast("출석체크 코드를 확인해주세요", duration: 2, point: point, title: nil, image: nil, style: toastStyle, completion: nil)
            self.codeTextFields.first?.becomeFirstResponder()
        }
    }
    
    @objc private func popViewController(animated: Bool = true) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func startLoadingIndicator() {
        self.indicatorView.isHidden = false
        self.indicatorView.startAnimating()
    }
    
    private func stopLoadingIndicator() {
        self.indicatorView.stopAnimating()
        self.indicatorView.isHidden = true
    }
}

// MARK: - UITextFieldDelegate
extension AttendanceCodeDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        defer { self.requestCodeIfNeeded() }
        
        let currentText = textField.text ?? ""
        let newText = range.lowerBound == 0 ? string : currentText.replaced(string, in: range) ?? ""
        
        if newText.count == 0 {
            textField.text = newText
            self.prevTextField(textField)?.becomeFirstResponder()
        } else {
            self.fillTextField(textField, with: newText)
        }
        return false
    }
    
    // MARK: - TextField Values
    private func textFieldIndex(of textField: UITextField) -> Int? {
        for index in 0..<self.codeTextFields.count {
            if textField == self.codeTextFields[index] {
                return index
            }
        }
        return nil
    }
    
    private func prevTextField(_ textField: UITextField) -> UITextField? {
        guard let index = self.textFieldIndex(of: textField) else { return nil }
        return self.codeTextFields[safe: index - 1]
    }
    
    private func nextTextField(_ textField: UITextField) -> UITextField? {
        guard let index = self.textFieldIndex(of: textField) else { return nil }
        return self.codeTextFields[safe: index + 1]
    }
    
    // MARK: - TextField Actions
    private func fillTextField(_ textField: UITextField, with string: String) {
        let string = string.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted)
        guard !string.isEmpty else { return }
        textField.text = string[safe: 0]
        
        guard let nextTextField = self.nextTextField(textField) else { return }
        nextTextField.becomeFirstResponder()
        if nextTextField.text?.isEmpty == false {
            self.setCursor(of: nextTextField, at: 0)
        }
        self.fillTextField(nextTextField, with: string[1..<string.count])
    }
    
    private func clearTextField(after textField: UITextField) {
        guard let index = self.textFieldIndex(of: textField) else { return }
        let nextIndex: Int = index + 1
        let totalCount = self.codeTextFields.count
        
        for index in nextIndex..<totalCount {
            self.codeTextFields[safe: index]?.text = ""
        }
    }
    
    private func clearAllTextField() {
        self.codeTextFields.forEach { textField in
            textField.text = ""
        }
    }
    
    private func setCursor(of textField: UITextField, at position: Int) {
        let position = textField.position(from: textField.beginningOfDocument, offset: position)!
        textField.selectedTextRange = textField.textRange(from: position, to: position)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.superview?.layer.borderColor = UIColor.main.cgColor
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.superview?.layer.borderColor = UIColor.init(white: 1, alpha: 0.5).cgColor
        return true
    }
}
