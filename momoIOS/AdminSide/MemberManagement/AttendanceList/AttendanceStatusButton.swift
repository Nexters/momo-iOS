//
//  AttendanceStatusButton.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/26.
//

import UIKit

enum AttendanceStatus: CaseIterable {
    /// 대기
    case waiting
    /// 정상출석
    case attendance
    /// 지각
    case lateness
    /// 통보결석
    case noticedAbsence
    /// 무단결석
    case truancy
    
    var title: String {
        switch self {
        case .waiting:
            return "대기"
        case .attendance:
            return "정상출석"
        case .lateness:
            return "지각"
        case .noticedAbsence:
            return "통보결석"
        case .truancy:
            return "무단결석"
        }
    }
    
    var color: UIColor {
        switch self {
        case .waiting:
            return .pastbox
        case .attendance:
            return .attendanceCheck
        case .lateness:
            return .attendanceLate
        case .noticedAbsence:
            return .noticeAbsance
        case .truancy:
            return .warning
        }
    }
}

protocol AttendanceStatusButtonDelegate: AnyObject {
    func didSelect(status: AttendanceStatus)
}

final class AttendanceStatusButton: UIButton {
    weak var delegate: AttendanceStatusButtonDelegate?
    private var pickerViewStatus: AttendanceStatus?
    
    var name: String?
    var status: AttendanceStatus = .waiting {
        didSet {
            self.setTitle(self.status.title, font: .tag2, color: .white)
            self.configurate(bgColor: self.status.color, cornerRadius: 6, padding: 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
    }
    
    convenience init(status: AttendanceStatus) {
        self.init(frame: .init(origin: .zero, size: .init(width: 57, height: 28)))
        self.status = status
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func showPicker() {
        let alert = UIAlertController(title: self.name, message: "\n\n\n\n\n\n", preferredStyle: .alert)
        let pickerView = UIPickerView(frame: .init(x: 0, y: 40, width: 270, height: 120))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { [weak self] _ in
            self?.pickerViewStatus = nil
        }
        let confirmAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let status = self?.pickerViewStatus else { return }
            self?.delegate?.didSelect(status: status)
            self?.pickerViewStatus = nil
        }
        
        alert.view.addSubview(pickerView)
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        
        UIApplication.topViewController()?.present(alert, animated: true)
    }
}

extension AttendanceStatusButton: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickerViewStatus = AttendanceStatus.allCases[safe: row]
    }
}
extension AttendanceStatusButton: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        AttendanceStatus.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        AttendanceStatus.allCases[safe: row]?.title
    }
}
