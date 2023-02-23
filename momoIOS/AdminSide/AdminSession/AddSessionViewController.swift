//
//  AddSessionViewController.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/02/11.
//

import UIKit
import SnapKit
import PhotosUI

// MARK: - 어드민 세션 등록 뷰 컨트롤러
class AddSessionViewController: UIViewController {
    let addSessionView = AddSessionView()
    let imgPicker = UIImagePickerController()
    let dateAlert = UIAlertController()
    let startTimeAlert = UIAlertController()
    let endTimeAlert = UIAlertController()
    override func viewDidLoad() {
        super.viewDidLoad()

        setBaseView()
        setNavCustom()
        setDateAlertAction()
        setTimeAlertAction()
        setImagePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let keyboardDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        
        UIView.animate(
            withDuration: keyboardDuration, animations: {
                self.addSessionView.scrollView.snp.remakeConstraints { make in
                    make.top.leading.trailing.equalToSuperview()
                    make.bottom.equalToSuperview().inset(keyboardSize.height + 10)
                }
            }
        )
    }

    @objc func keyboardWillHide(_ notification: NSNotification) {
        self.addSessionView.scrollView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setNavCustom() {
        self.navigationItem.title = "세션 등록"
        let deleteBtn = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(didTapDeleteButton))
        let backBtn = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(didTapBackButton))
        self.navigationItem.rightBarButtonItem = deleteBtn
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    private func setImagePicker() {
        self.imgPicker.sourceType = .photoLibrary
        self.imgPicker.allowsEditing = true
        self.imgPicker.delegate = self
    }
    
    private func setBaseView() {
        self.view.backgroundColor = .white
        addSessionView.initViews(self.view)
        addSessionView.dateBtn.addTarget(self, action: #selector(didTapDatePickerBtn), for: .touchUpInside)
        addSessionView.timeBtn.addTarget(self, action: #selector(didTapTimePickerBtn), for: .touchUpInside)
        addSessionView.placeBtn.addTarget(self, action: #selector(didTapSetPlaceBtn), for: .touchUpInside)
        addSessionView.sessionImgBtn.addTarget(self, action: #selector(didTapSessionImgBtn), for: .touchUpInside)
        addSessionView.detailTxtField.delegate = self
        addSessionView.detailTxtField.delegate = self
        addSessionView.addressTxtField.delegate = self
        addSessionView.keywordTxtField.delegate = self
    }
    
    private func setDateAlertAction() {
        let pickerVC = UIViewController()
        let datePicker = UIDatePicker()

        datePicker.datePickerMode = .date
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.addTarget(self, action: #selector(didSelectDate), for: .valueChanged)
        pickerVC.view = datePicker
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        self.dateAlert.addAction(cancel)
        self.dateAlert.setValue(pickerVC, forKey: "contentViewController")
    }
    
    private func setTimeAlertAction() {
        self.startTimeAlert.title = "시작 시간 선택"
        self.endTimeAlert.title = "종료 시간 선택"

        let startTimePickerVC = UIViewController()
        let endTimePickerVC = UIViewController()
        let startDatePicker = UIDatePicker()
        let endDatePicker = UIDatePicker()
        
        startDatePicker.datePickerMode = .time
        if #available(iOS 14.0, *) {
            startDatePicker.preferredDatePickerStyle = .wheels
        }
        startDatePicker.locale = Locale(identifier: "ko_KR")
        
        endDatePicker.datePickerMode = .time
        if #available(iOS 14.0, *) {
            endDatePicker.preferredDatePickerStyle = .wheels
        }
        endDatePicker.locale = Locale(identifier: "ko_KR")
        
        startTimePickerVC.view = startDatePicker
        endTimePickerVC.view = endDatePicker
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let startCancel = UIAlertAction(title: "취소", style: .cancel, handler: { [weak self] _ in
            self?.addSessionView.timeBtn.titleLabel?.text?.removeAll()
        })
        
        let endCancel = UIAlertAction(title: "취소", style: .cancel, handler: { [weak self] _ in
            self?.addSessionView.timeBtn.titleLabel?.text?.removeAll()
        })
        
        let next = UIAlertAction(title: "다음", style: .default, handler: { [weak self] _ in
            self?.present(self!.endTimeAlert, animated: true)
            self?.addSessionView.timeBtn.setTitle(dateFormatter.string(from: startDatePicker.date), size: 14, weight: .medium, color: UIColor(hex: 0x4F505C))
            self?.addSessionView.timeBtn.setBorderAnimation()
        })
        
        let confirm = UIAlertAction(title: "확인", style: .default, handler: {[weak self] _ in
            guard let str = self?.addSessionView.timeBtn.titleLabel?.text else {return}
            self?.addSessionView.timeBtn.setTitle("\(str) ~ \(dateFormatter.string(from: endDatePicker.date))", size: 14, weight: .medium, color: UIColor(hex: 0x4F505C))
        })
        
        startTimeAlert.addAction(startCancel)
        startTimeAlert.addAction(next)
        
        endTimeAlert.addAction(confirm)
        endTimeAlert.addAction(endCancel)
        
        startTimeAlert.setValue(startTimePickerVC, forKey: "contentViewController")
        endTimeAlert.setValue(endTimePickerVC, forKey: "contentViewController")
    }
}

// MARK: - event 처리 용 extension
extension AddSessionViewController {
    @objc func didTapDeleteButton(_ sender: UIButton) {
        let absenceModal = AddSessionAlertViewController()
        absenceModal.setTitleLabel(title: "세션을 삭제하시나요?", description: "삭제하신다면 세션 내용은 지워지며,\n다시 새로 등록하셔야 합니다.", leftBtnTitle: "취소", rightBtnTitle: "삭제")
        absenceModal.modalPresentationStyle = .overFullScreen
        absenceModal.confirmClosure = { [weak self] in
            // MARK: 삭제 로직 추가
            self?.navigationController?.popViewController(animated: true)
        }
        self.present(absenceModal, animated: true)
    }
    
    @objc func didTapBackButton(_ sender: UIButton) {
        let absenceModal = AddSessionAlertViewController()
        absenceModal.setTitleLabel(title: "저장하지 않고 나가시나요?", description: "나가신다면 작성한 내용은 저장되지 않습니다.", leftBtnTitle: "취소", rightBtnTitle: "나가기")
        absenceModal.confirmClosure = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        absenceModal.modalPresentationStyle = .overFullScreen
        self.present(absenceModal, animated: true)
    }
    
    @objc func didTapTimePickerBtn(_ sender: UIButton) {
        self.present(startTimeAlert, animated: true)
    }
    
    @objc func didTapDatePickerBtn(_ sender: UIButton) {
        self.present(dateAlert, animated: true)
    }
    
    @objc func didSelectDate(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 dd일"

        self.dateAlert.dismiss(animated: true)
        self.addSessionView.dateBtn.setTitle(formatter.string(from: sender.date), size: 14, weight: .medium, color: UIColor(hex: 0x4F505C))
        self.addSessionView.dateBtn.setBorderAnimation()
    }
    
    @objc func didTapSetPlaceBtn(_ sender: UIButton) {
        self.navigationController?.pushViewController(RegisterPlaceViewController(), animated: true)
    }
    
    @objc func didTapSessionImgBtn(_ sender: UIButton) {
        self.present(imgPicker, animated: true)
    }
}

// MARK: - text view delegate 용 extension
extension AddSessionViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor != UIColor(hex: 0x4F505C) {
            textView.text.removeAll()
            textView.textColor = UIColor(hex: 0x4F505C)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor(hex: 0xB3B6C5)
            textView.text = "세션을 대표하는 정보를 입력해주세요"
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.endEditing(true)
            return true
        }
        guard let str = textView.text else { return true }
        let newLength = str.count + text.count - range.length
        return newLength <= 300
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count == 1 {
            UIView.animate(withDuration: 1, delay: 0, animations: {
                textView.layer.borderWidth = 1
                textView.backgroundColor = UIColor(hex: 0xD5CCEE, alpha: 0.2)
            })
        }
        
        addSessionView.scrollView.contentLayoutGuide.snp.updateConstraints { make in
            make.height.equalTo(860 + textView.intrinsicContentSize.height)
        }
        
        textView.snp.updateConstraints { make in
            make.height.equalTo(textView.intrinsicContentSize.height)
        }
        addSessionView.countLabel.text = String(textView.text.count)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - 이미지 피커 컨트롤러 용 extension
extension AddSessionViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage? = nil
        
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }
        
        self.addSessionView.setSessionImage(image: newImage)
        picker.dismiss(animated: true)
    }
}
