//
//  UITableView+Extension.swift
//  momoIOS
//
//  Created by 임수현 on 2023/04/02.
//

import UIKit

extension UITableView {
    func isLast(for indexPath: IndexPath) -> Bool {
        let lastSection = self.numberOfSections > 0 ? self.numberOfSections - 1 : 0
        let lastRowInLastSection = self.numberOfRows(inSection: lastSection) - 1

        return indexPath.section == lastSection && indexPath.row == lastRowInLastSection   
    }
}
