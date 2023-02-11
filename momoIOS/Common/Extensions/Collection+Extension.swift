//
//  Collection+Extension.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/11.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
