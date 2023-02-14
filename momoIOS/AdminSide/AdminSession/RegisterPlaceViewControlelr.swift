//
//  RegisterPlaceViewControlelr.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/14.
//

// MARK: - 어드민 세션 등록 중 장소 등록 뷰 컨트롤러
import UIKit
import SnapKit

class RegisterPlaceViewController: UIViewController {
    
    // MARK: - Properties
    
    private let searchBar = UIView()
    private let searchTextField = CommonTextField(placeholderText: "검색")
    private let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)))
    private let searchGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "도로명이나 지역명을 이용해서 검색해보세요.\n건물번호, 번지를 입력하시면 정확하게 검색됩니다."
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = .rgba(138, 138, 138, 1)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupCustomNav()
        self.setupLayout()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Selectors
    
    @objc private func goBackToAddSessionVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helpers
    
    private func setupCustomNav() {
        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .rgba(24, 24, 24, 0.16)
        appearance.backgroundColor = .white
        
        let navBar = self.navigationController?.navigationBar
        navBar?.scrollEdgeAppearance = appearance
        navBar?.tintColor = .black
        
        self.navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(goBackToAddSessionVC))
        
        let title = UILabel()
        title.text = "장소등록"
        title.font = .systemFont(ofSize: 16, weight: .semibold)
        self.navigationItem.titleView = title
    }
    
    private func setupSearchBar() {
        searchBar.addSubviews(searchTextField, searchIcon)
        searchIcon.image = searchIcon.image?.withRenderingMode(.alwaysTemplate)
        searchIcon.tintColor = .black
        
        searchTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(searchBar)
            make.verticalEdges.equalTo(searchBar)
        }
        
        searchIcon.snp.makeConstraints { make in
            make.right.equalTo(searchBar).inset(15)
            make.centerY.equalTo(searchTextField)
        }
    }
    
    private func setupLayout() {
        setupSearchBar()
        view.addSubviews(searchBar, searchGuideLabel)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        searchGuideLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(24)
        }
    }
}
