//
//  RegisterPlaceViewControlelr.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/14.
//

// MARK: - 어드민 세션 등록 중 장소 등록 뷰 컨트롤러
import UIKit
import SnapKit
import GooglePlaces

class RegisterPlaceViewController: UIViewController {
    
    // MARK: - Properties
    private let searchBar = UISearchBar()
    private let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)))
    private let searchGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "도로명이나 지역명을 이용해서 검색해보세요.\n건물번호, 번지를 입력하시면 정확하게 검색됩니다."
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .rgba(138, 138, 138, 1)
        label.numberOfLines = 0
        return label
    }()
    
    private var resultTableView: UITableView!
    private var tableDataSource: GMSAutocompleteTableDataSource!
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupCustomNav()
        self.setupResultTableView()
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
        let navBar = self.navigationController?.navigationBar
        navBar?.tintColor = .black
        
        self.navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(goBackToAddSessionVC))
        
        let title = UILabel()
        title.text = "장소등록"
        title.font = .systemFont(ofSize: 16)
        self.navigationItem.titleView = title
    }
    
    private func setupSearchArea() {
        searchBar.delegate = self
        
        /// searchBar의 배경색 지정
        searchBar.backgroundColor = .rgba(248, 248, 249, 1)
        
        /// default border를 없애고 searchBar 내 textField 배경색 지정
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextField.backgroundColor = .rgba(248, 248, 249, 1)
        searchBar.searchBarStyle = .minimal
        
        /// placeholder와 text 속성 설정
        searchBar.searchTextField.font = .systemFont(ofSize: 14, weight: .medium)
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "검색",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.rgba(179, 182, 197, 1),
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)])
        // TODO: - placeholder의 foregroundColor는 GUI의 gray500, 추후 extension에 추가되면 수정
        
        /// 이외 속성들 설정
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.layer.borderWidth = 1
        searchBar.layer.cornerRadius = 8
        searchBar.layer.borderColor = UIColor.clear.cgColor
        
        view.addSubviews(searchBar, searchIcon)
        searchIcon.image = searchIcon.image?.withRenderingMode(.alwaysTemplate)
        searchIcon.tintColor = .black
    }
    
    private func setupResultTableView() {
        tableDataSource = GMSAutocompleteTableDataSource()
        self.tableDataSource.delegate = self
        
        resultTableView = UITableView(frame: CGRect(x: 0, y: 200, width: self.view.frame.size.width, height: self.view.frame.size.height - 44))
        self.resultTableView.delegate = tableDataSource
        self.resultTableView.dataSource = tableDataSource
    }
    
    private func setupLayout() {
        self.setupSearchArea()
        self.view.addSubview(searchGuideLabel)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(24)
        }

        searchIcon.snp.makeConstraints { make in
            make.right.equalTo(searchBar).inset(15)
            make.centerY.equalTo(searchBar)
        }
        
        searchGuideLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(24)
        }
    }
}

extension RegisterPlaceViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addSubview(resultTableView)
        resultTableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        for sub in self.view.subviews {
            if let subview = sub as? UITableView {
                subview.removeFromSuperview()
                break
            }
        }
        self.searchBar.endEditing(true)
        self.searchBar.text = ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Update the GMSAutocompleteTableDataSource with the search text.
        tableDataSource.sourceTextHasChanged(searchText)
    }
}

extension RegisterPlaceViewController: GMSAutocompleteTableDataSourceDelegate {
    func didUpdateAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        // Reload table data.
        resultTableView.reloadData()
    }

    func didRequestAutocompletePredictions(for tableDataSource: GMSAutocompleteTableDataSource) {
        // Reload table data.
        resultTableView.reloadData()
    }

    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didAutocompleteWith place: GMSPlace) {
        // Do something with the selected place.
        print("\(place.formattedAddress)")
        
        for sub in self.view.subviews {
            if let subview = sub as? UITableView {
                subview.removeFromSuperview()
                break
            }
        }
        self.searchBar.endEditing(true)
        self.searchBar.text = "" /// Notes: 장소를 선택한 후 UISearchBar의 text를 비워주지 않으면 placeholder가 검색어로 바뀜.
    }

    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        // Handle the error.
        print("Error: \(error.localizedDescription)")
    }

    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        return true
    }
}
