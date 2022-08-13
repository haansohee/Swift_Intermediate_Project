//
//  Alert.swift
//  Drink
//
//  Created by 한소희 on 2022/08/13.
//

import Foundation

struct Alert: Codable {
    var id: String = UUID().uuidString
    var date: Date  // 시간
    var isOn: Bool
    
    var time: String {  // 데이트 값을 받으면 우리가 바로 라벨에 뿌려 줄 수 있는 시간값과 오전,오후 값을 뱉을 수 있도록...
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm"
        return timeFormatter.string(from: date)
    }
    
    var meridiem: String {
        let meridiemFormatter = DateFormatter()
        meridiemFormatter.dateFormat = "a"
        meridiemFormatter.locale = Locale(identifier: "ko")
        return meridiemFormatter.string(from: date)
    }
}
