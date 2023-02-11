//
//  Optional+Extension.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/11.
//

import Foundation

extension Optional {
    var isNil: Bool {
        self == nil
    }
    var isNotNil: Bool {
        self != nil
    }
}

extension String? {
    var isEmptyOrNil: Bool {
        self?.isEmpty == true || self.isNil
    }
}
