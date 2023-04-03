//
//  UNNotificationCenter.swift
//  DrinkWater
//
//  Created by 한소희 on 2023/04/03.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    // alert객체를 받아서 리퀘스트를 만들고 최종적으로 notification에 추가하는 함수
    func addNotificationRequest(by alert: Alert) {
        // 알림의 내용이 될 content 설정
        let content = UNMutableNotificationContent()
        content.title = "물 마실 시간이에요 🌊"
        content.body = "세계보건기구(WHO)가 권장하는 하루 물 섭취량은 1.5~2리터입니다."
        content.sound = .default
        content.badge = 1
        
        let component = Calendar.current.dateComponents([.hour, .minute], from: alert.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: alert.isOn)
    }
}
