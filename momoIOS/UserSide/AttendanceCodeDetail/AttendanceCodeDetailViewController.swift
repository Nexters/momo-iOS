//
//  AttendanceCodeDetailViewController.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/09.
//

import UIKit

class AttendanceCodeDetailViewController: UIViewController {
    private let backgroundView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let codeContainerView: UIStackView = UIStackView()
    private let codeTextFields: [UITextField] = [UITextField(), UITextField(), UITextField(), UITextField()]
    private let descriptionLabel: UILabel = UILabel()
    private let attendButton: UIButton = UIButton()
    
    private var inputCodeString: String {
        var string = ""
        self.codeTextFields.forEach { textField in
            string.append(textField.text ?? " ")
        }
        return string
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupKeyboardNotifications()
        self.setupViews()
        self.setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.setupNavigation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Setup
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    private func setupNavigation() {
        let navigationBar = self.navigationController?.navigationBar
        let appearance = navigationBar?.standardAppearance ?? UINavigationBarAppearance()
        appearance.shadowColor = .rgba(24, 24, 24, 0.16)
        appearance.backgroundColor = .white.withAlphaComponent(0.96)
        navigationBar?.standardAppearance = appearance
        
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
        
        self.backgroundView.backgroundColor = .rgba(128, 135, 201, 1)
        self.backgroundView.layer.cornerRadius = 12
        
        self.titleLabel.text = "출석체크 코드 입력"
        self.titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        self.titleLabel.textColor = .white
        
        self.codeContainerView.axis = .horizontal
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
        
        self.descriptionLabel.text = "운영진이 공지해준 출석체크 코드를 입력해주세요!"
        self.descriptionLabel.font = .systemFont(ofSize: 12)
        self.descriptionLabel.textColor = .white.withAlphaComponent(0.67)
        self.backgroundView.addSubview(self.descriptionLabel)
        
        self.attendButton.setTitle("출석하기", size: 16, weight: .bold, color: .white)
        self.configureAttendButtonEnabled()
        self.attendButton.addTarget(self, action: #selector(didTapAttendButton), for: .touchUpInside)
    }
    
    // MARK: - Layout
    private func setupLayout() {
        self.view.addSubview(self.backgroundView)
        self.backgroundView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(30)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(24)
        }
        
        self.backgroundView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(35)
            make.centerX.equalToSuperview()
        }
        
        self.backgroundView.addSubview(self.codeContainerView)
        self.codeContainerView.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(54)
            make.leading.trailing.equalToSuperview().inset(53)
        }
        
        self.codeTextFields.forEach { textField in
            let codeView = UIStackView()
            codeView.axis = .vertical
            let view = UIView()
            view.backgroundColor = .white
            
            codeView.addArrangedSubviews(textField, view)
            textField.snp.makeConstraints { make in
                make.width.equalTo(45)
                make.height.equalTo(70)
            }
            view.snp.makeConstraints { make in
                make.width.equalTo(textField)
                make.height.equalTo(1)
            }
            
            self.codeContainerView.addArrangedSubview(codeView)
        }
        self.backgroundView.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.codeContainerView.snp.bottom).offset(33)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(42)
        }
        
        self.view.addSubview(self.attendButton)
        self.attendButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(28)
            make.height.equalTo(54)
        }
    }
    
    // MARK: - Actions
    @objc private func didTapAttendButton() {
        self.popViewController()
    }
    
    private func configureAttendButtonEnabled() {
        let isAttendButtonEnabled = {
            for textField in self.codeTextFields where textField.text.isEmptyOrNil {
                return false
            }
            return true
        }()
        
        if isAttendButtonEnabled {
            self.attendButton.isEnabled = true
            self.attendButton.configurate(bgColor: .rgba(56, 56, 56, 1), cornerRadius: 7, padding: 10)
        } else {
            self.attendButton.isEnabled = false
            self.attendButton.configurate(bgColor: .rgba(200, 200, 200, 1), cornerRadius: 7, padding: 10)
        }
    }
    
    @objc private func popViewController(animated: Bool = true) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension AttendanceCodeDetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        defer { self.configureAttendButtonEnabled() }
        
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
    private var isEditingCode: Bool {
        for textField in self.codeTextFields where textField.isEditing == true {
            return true
        }
        return false
    }
    
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
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        if self.isEditingCode {
            self.attendButton.moveWithKeyboard(
                willShow: true,
                notification: notification,
                safeAreaBottomInset: self.view.safeAreaInsets.bottom
            )
        }
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        self.attendButton.moveWithKeyboard(
            willShow: false,
            notification: notification,
            safeAreaBottomInset: self.view.safeAreaInsets.bottom
        )
    }
    
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
    
    private func setCursor(of textField: UITextField, at position: Int) {
        let position = textField.position(from: textField.beginningOfDocument, offset: position)!
        textField.selectedTextRange = textField.textRange(from: position, to: position)
    }
}
