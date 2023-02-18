//
//  momo++Bundle.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/16.
//

import Foundation

extension Bundle {
    var googleMapsAPIKey: String {
        guard let file = self.path(forResource: "API", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["GOOGLE_MAPS_API_KEY"] as? String else { fatalError("API.plist 내 API KEY 설정 필요") }
        return key
    }
}
