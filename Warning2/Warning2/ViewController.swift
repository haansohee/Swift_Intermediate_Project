//
//  ViewController.swift
//  Warning2
//
//  Created by 한소희 on 2023/04/25.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var label1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UNUserNotificationCenter.current().getNotificationSettings {
            settings in
            if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    self.switch1.isOn = true
                    UserDefaults.standard.set(self.switch1.isOn, forKey: "switchState")
                }
            } else {
                DispatchQueue.main.async {
                    self.switch1.isOn = false
                    UserDefaults.standard.set(self.switch1.isOn, forKey: "switchState")
                }
            }
        }
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if switch1.isOn {
            UserDefaults.standard.set(switch1.isOn, forKey: "switchState")
            self.label1.text = "ON"

            
            //test
            UNUserNotificationCenter.current().getNotificationSettings {
                settings in
                print("on 확인: \(settings)")
            }
            
        } else {
            UserDefaults.standard.set(!switch1.isOn, forKey: "switchState")
            self.label1.text = "OFF"
            
            //test
            UNUserNotificationCenter.current().getNotificationSettings {
                settings in
                print("off 확인: \(settings)")
            }            
        }
    }
}




