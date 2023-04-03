//
//  AppDelegate.swift
//  DrinkWater
//
//  Created by 한소희 on 2023/03/31.
//

import UIKit
import NotificationCenter
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var userNotificationCenter: UNUserNotificationCenter?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // notification 델리게이트 선언
        UNUserNotificationCenter.current().delegate = self
        
        // 사용자에게 알림 허용을 받는 코드 authrizationOptions
        let authrizationOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        
        // userNotificationCenter 초기화
        self.userNotificationCenter = UNUserNotificationCenter.current()
        
        userNotificationCenter?.requestAuthorization(options: authrizationOptions) { _, error in
            if let error = error {
                print("ERROR: notification authrization request \(error.localizedDescription)")
            }
        }
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // notificationCenter를 보내기 전에 어떤 핸들링 할 것인지
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
