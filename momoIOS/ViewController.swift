//
//  ViewController.swift
//  momoIOS
//
//  Created by JOSUEYEON on 2023/01/28.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    // MARK: - Views
    private let mainButton: UIButton = UIButton()
    private let otherButton: UIButton = UIButton()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupButtonActions()
    }
    
    // MARK: - Setup
    private func setupViews() {
        self.mainButton.setTitle("Main으로 이동", for: .normal)
        self.otherButton.setTitle("...으로 이동", for: .normal)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubview(self.mainButton)
        stackView.addArrangedSubview(self.otherButton)
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupButtonActions() {
        self.mainButton.addTarget(self, action: #selector(goToMainViewController), for: .touchUpInside)
        self.otherButton.addTarget(self, action: #selector(goToOtherViewController), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func goToMainViewController() {
        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
    @objc private func goToOtherViewController() {
//        self.navigationController?.pushViewController(MainViewController(), animated: true)
    }
}
