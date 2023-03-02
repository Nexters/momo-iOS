//
//  Attendance.swift
//  momoIOS
//
//  Created by 문다 on 2023/02/26.
//

import UIKit

enum AttendanceType {
    case present
    case late
    case AWOL // Absent without leave 무단결석
    case AWL // Absent with leave 통보결석
}

struct Attendance {
    let icon: String
    let toString: String
    let textColor: UIColor
    let backgroundColor: UIColor
    let score: Int
}
