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
    private let searchIcon = UIImageView(image: UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)))
    private let searchGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "도로명이나 지역명을 이용해서 검색해보세요.\n건물번호, 번지를 입력하시면 정확하게 검색됩니다."
        label.font = .body16
        label.textColor = .rgba(138, 138, 138, 1)
        label.numberOfLines = 0
        return label
    }()
    
    private var resultTableView: UITableView!
    private var tableDataSource: GMSAutocompleteTableDataSource!
    var didTapPlaceClosure: ((String) -> Void)?
    
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
        title.font = .body16
        self.navigationItem.titleView = title
    }
    
    private func setupSearchArea() {
        searchBar.delegate = self
        searchBar.placeholder = "검색"
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.clearButtonMode = .never
        searchBar.layer.borderWidth = 1
        searchBar.layer.cornerRadius = 8
        searchBar.layer.borderColor = UIColor.rgba(230, 230, 230, 1).cgColor
        
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
        guard let point = place.formattedAddress else {
            return
        }
        self.didTapPlaceClosure?(point)
        self.navigationController?.popViewController(animated: true)
    }

    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didFailAutocompleteWithError error: Error) {
        // Handle the error.
        print("Error: \(error.localizedDescription)")
    }

    func tableDataSource(_ tableDataSource: GMSAutocompleteTableDataSource, didSelect prediction: GMSAutocompletePrediction) -> Bool {
        return true
    }
}
