//
//  ViewController.swift
//  Warning2
//
//  Created by 한소희 on 2023/04/25.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    let center = UNUserNotificationCenter.current()
    
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let notification = !UserDefaults.standard.bool(forKey: "notification")
        switch1.isOn = notification
        
        print("아아ㅡㄴ아르ㅏ으아ㅏ앙아아아아아아 \(notification)")
    }
    
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if switch1.isOn {
            UserDefaults.standard.set(!sender.isOn, forKey: "notification")
            self.label1.text = "ON"
            print("오우예씨몽")
            
            center.getNotificationSettings {
                settings in
                if settings.authorizationStatus == .authorized {
                    print("씨몽 YES")
                }
            }
            
        } else {
            UserDefaults.standard.set(sender.isOn, forKey: "notification")
            self.label1.text = "OFF"
            print("오우예씨몽")
            
            center.getNotificationSettings {
                settings in
                if settings.authorizationStatus == .denied {
                    print("씨몽 NO")
                }
            }
        }
    }
}


