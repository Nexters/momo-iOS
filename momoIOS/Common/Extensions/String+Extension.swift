//
//  String+Extension.swift
//  momoIOS
//
//  Created by 임수현 on 2023/02/11.
//

import Foundation

extension String {
    subscript (safe index: Int) -> String? {
        guard self.count > index else { return nil }
        let index = self.index(self.startIndex, offsetBy: index)
        return "\(self[index])"
    }
    
    subscript (range: Range<Int>) -> String? {
        let fromIndex = self.index(self.startIndex, offsetBy: max(0, range.lowerBound))
        let toIndex = self.index(self.startIndex, offsetBy: min(range.upperBound, self.count))
        return String(self[fromIndex..<toIndex])
    }
    
    subscript(_ range: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: range.startIndex)
        let toIndex = self.index(self.startIndex, offsetBy: range.endIndex)
        return String(self[fromIndex..<toIndex])
    }
    
    func replaced(_ string: String, in range: NSRange) -> String? {
        guard let range = Range(range, in: self) else { return nil }
        return self.replacingCharacters(in: range, with: string)
    }
    
    var isBackspace: Bool {
        if let char = self.cString(using: String.Encoding.utf8) {
            return strcmp(char, "\\b") == -92
        }
        return false
    }
}
